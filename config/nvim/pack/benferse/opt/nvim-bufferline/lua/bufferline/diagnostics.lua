local utils = require("bufferline.utils")

local M = {}

local fn = vim.fn

local severity_name = {
  [1] = "error",
  [2] = "warning",
  [3] = "info",
  [4] = "hint",
  [5] = "other",
}

setmetatable(severity_name, {
  __index = function()
    return "other"
  end,
})

local last_diagnostics_result = {}

local function get_err_dict(errs)
  local ds = {}
  local max = #severity_name
  for _, err in ipairs(errs) do
    if err then
      -- calculate max severity
      local sev_num = err.severity
      local sev_level = severity_name[sev_num]
      if sev_num < max then
        max = sev_num
      end
      -- increment diagnostics dict
      if ds[sev_level] then
        ds[sev_level] = ds[sev_level] + 1
      else
        ds[sev_level] = 1
      end
    end
  end
  local max_severity = severity_name[max]
  return { level = max_severity, errors = ds }
end

local mt = {
  __index = function(_, _)
    return { count = 0, level = nil }
  end,
}

local is_nightly = utils.is_truthy(fn.has("nvim-0.7"))
local is_valid_version = utils.is_truthy(fn.has("nvim-0.5"))

local function is_disabled(diagnostics)
  if
    not diagnostics
    or not vim.tbl_contains({ "nvim_lsp", "coc" }, diagnostics)
    -- check if the current nvim version is one that will have either vim.diagnostics or vim.lsp.diagnostics
    or (diagnostics == "nvim_lsp" and not is_valid_version)
    or (diagnostics == "coc" and vim.g.coc_service_initialized ~= 1)
  then
    return true
  end
  return false
end

local function is_insert() -- insert or replace
  local mode = vim.api.nvim_get_mode().mode
  return mode == "i" or mode == "ic" or mode == "ix" or mode == "R" or mode == "Rc" or mode == "Rx"
end

local get_diagnostics = {
  nvim_lsp = function()
    if utils.is_truthy(fn.has("nvim-0.6.1")) then
      local results = {}
      local diagnostics = vim.diagnostic.get()

      for _, d in pairs(diagnostics) do
        if not results[d.bufnr] then
          results[d.bufnr] = {}
        end

        table.insert(results[d.bufnr], d)
      end

      return results
    end
    ---@diagnostic disable-next-line: deprecated
    return vim.lsp.diagnostic.get_all()
  end,

  coc = (function()
    local diagnostics = {}
    local function refresh_cb(err, res)
      if err ~= vim.NIL then
        return
      end
      res = type(res) == "table" and res or {}

      local result = {}
      local bufname2bufnr = {}
      for _, diagnostic in ipairs(res) do
        local bufname = diagnostic.file
        local bufnr = bufname2bufnr[bufname]
        if not bufnr then
          bufnr = fn.bufnr(bufname)
          bufname2bufnr[bufname] = bufnr
        end

        if bufnr ~= -1 then
          result[bufnr] = result[bufnr] or {}
          table.insert(result[bufnr], { severity = diagnostic.level })
        end
      end
      diagnostics = result
    end
    return function()
      fn.CocActionAsync("diagnosticList", refresh_cb)
      return diagnostics
    end
  end)(),
}

---@param opts table
function M.get(opts)
  if is_disabled(opts.diagnostics) then
    return setmetatable({}, mt)
  end
  if is_insert() and not opts.diagnostics_update_in_insert then
    return setmetatable(last_diagnostics_result, mt)
  end
  local diagnostics = get_diagnostics[opts.diagnostics]()
  local result = {}
  for buf_num, items in pairs(diagnostics) do
    local d = get_err_dict(items)
    result[buf_num] = {
      count = #items,
      level = d.level,
      errors = d.errors,
    }
  end
  last_diagnostics_result = result
  return setmetatable(result, mt)
end

---@param context RenderContext
function M.component(context)
  local opts = context.preferences.options
  if is_disabled(opts.diagnostics) then
    return context
  end

  local user_indicator = opts.diagnostics_indicator
  local highlights = context.current_highlights
  local buf = context.tab:as_buffer()
  local diagnostics = buf.diagnostics
  if diagnostics.count < 1 then
    return context
  end

  local indicator = " (" .. diagnostics.count .. ")"
  if user_indicator and type(user_indicator) == "function" then
    local ctx = { buffer = buf }
    indicator = user_indicator(diagnostics.count, diagnostics.level, diagnostics.errors, ctx)
  end

  --- Don't adjust the diagnostic indicator size if it is empty
  if not indicator or #indicator == 0 then
    return context
  end

  local highlight = highlights[diagnostics.level] or ""
  local diag_highlight = highlights[diagnostics.level .. "_diagnostic"]
    or highlights.diagnostic
    or ""
  local padding = require("bufferline.constants").padding
  local size = context.length + fn.strwidth(indicator) + fn.strwidth(padding)

  return context:update({
    length = size,
    component = highlight
      .. context.component
      .. diag_highlight
      .. indicator
      .. highlights.background
      .. padding,
  })
end

return M

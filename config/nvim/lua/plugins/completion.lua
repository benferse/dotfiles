-- Check whether the current position is inside a given syntax highlight group
local function is_in_syntax_group(group)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  if vim.api.nvim_get_mode().mode == "i" then
    col = col - 1
  end

  for _, syn_id in ipairs(vim.fn.synstack(row, col)) do
    syn_id = vim.fn.synIDtrans(syn_id)
    local g = vim.fn.synIDattr(syn_id, "name")
    if type(group) == "string" and g == group then
      return true
    elseif type(group) == "table" and vim.tbl_contains(group, g) then
      return true
    end
  end

  return false
end

-- Check whether the current position is inside a given treesitter capture context.
-- Note that this returns the leaf (most specific context), so it's best used for
-- contexts that don't contain other contexts
---@param capture string | []string
---@return boolean
local function is_in_ts_capture(capture)
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  if vim.api.nvim_get_mode().mode == "i" then
    col = col - 1
  end

  local get_captures_at_pos = require("vim.treesitter").get_captures_at_pos
  local captures = vim.tbl_map(function(x)
    return x.capture
  end, get_captures_at_pos(buf, row, col))

  if vim.tbl_isempty(captures) then
    return false
  elseif type(capture) == "string" and vim.tbl_contains(captures, capture) then
    return true
  elseif type(capture) == "table" then
    for _, v in ipairs(capture) do
      if vim.tbl_contains(captures, v) then
        return true
      end
    end
  end

  return false
end

return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.enabled = function()
        -- Disable autocompletion when inside a comment (but leave command mode completion enabled)
        if vim.api.nvim_get_mode().mode == "c" then
          return true
        else
          return not is_in_ts_capture("comment") and not is_in_syntax_group("Comment")
        end
      end
    end,
  },
}

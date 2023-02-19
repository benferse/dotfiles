local M = {}

M.root_patterns = { ".git" }

-- Check whether the current position is inside a given treesitter capture context.
-- Note that this returns the leaf (most specific context), so it's best used for
-- contexts that don't contain other contexts
---@param capture string | []string
---@return boolean
function M.is_in_ts_capture(capture)
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

-- Determine the "root" directory, using several potential heuristics, such as LSP folders,
-- git information, or arbitrary patterns. Shout out to folke, see
-- https://github.com/folke/LazyVim/blob/main/lua/lazyvim/util.lua
---@return string
function M.get_root()
    ---@type string?
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.loop.fs_realpath(path) or nil
    ---@type string[]
    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            local workspace = client.config.workspace_folders
            local paths = workspace
                and vim.tbl_map(function(ws)
                    return vim.uri_to_fname(ws.uri)
                end, workspace)
                or client.config.root_dir and { client.config.root_dir }
                or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    ---@type string?
    local root = roots[1]
    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        ---@type string?
        root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    ---@cast root string
    return root
end

return M

-- Core plugins and functionality the other features may
-- rely on

local M = {}

M.setup = function(args)
    vim.cmd([[
        packadd plenary.nvim
        packadd popup.nvim
    ]])
end

return M

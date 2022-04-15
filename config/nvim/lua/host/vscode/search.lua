local M = {}

M.in_files = function()
    vim.cmd [[
        call VSCodeNotify('workbench.action.findInFiles')
    ]]
end

M.by_word = function()
    vim.cmd [[
        call VSCodeNotify('workbench.action.findInFiles')
    ]]
return M

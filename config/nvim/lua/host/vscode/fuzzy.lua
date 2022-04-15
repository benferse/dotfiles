local M = {}

M.files = function()
    vim.cmd [[
        call VSCodeNotify('workbench.action.quickOpen')
    ]]
end

M.buffers = function()
    vim.cmd [[
        call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')
    ]]
end

M.recent = function()
    vim.cmd [[
        call VSCodeNotify('workbench.action.quickOpenRecent')
    ]]
end

M.projects = function() end

return M

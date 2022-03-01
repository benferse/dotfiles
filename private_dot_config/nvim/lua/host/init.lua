local M = {}

M.setup = function()
    if vim.fn.exists('g:vscode') == 1 then
        M.buffers = require('host.vscode.buffers')
        M.fuzzy   = require('host.vscode.fuzzy')
        M.help    = require('host.vscode.help')
        M.search  = require('host.vscode.search')
        M.windows = require('host.vscode.windows')
    else
        M.buffers = require('host.nvim.buffers')
        M.fuzzy   = require('host.nvim.fuzzy')
        M.help    = require('host.nvim.help')
        M.search  = require('host.nvim.search')
        M.windows = require('host.nvim.windows')
    end
end

return M

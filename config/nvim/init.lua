-- mapleader needs to be set before anything uses it
vim.g.mapleader = " "

-- Host-specific configuration
if vim.fn.exists('g:vscode') == 1 then
    vim.cmd('packadd host-vscode')
else
    vim.cmd('packadd host-nvim')
end

require('settings').setup()
require('keymaps').setup()
require('theme').setup()


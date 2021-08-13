-- mapleader needs to be set before anything uses it
vim.g.mapleader = " "

vim.cmd[[let g:airline#extensions#tabline#enabled = 1]]
vim.cmd[[let g:airline_theme = 'nord']]

-- Host-specific configuration
if vim.fn.exists('g:vscode') == 1 then
    vim.cmd('packadd host-vscode')
else
    vim.cmd('packadd host-nvim')
end

require('keymaps').setup()
require('theme').setup()

vim.cmd('set termguicolors')

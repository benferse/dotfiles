-- mapleader needs to be set before anything uses it
vim.g.mapleader = " "

-- Selectively load optional extensions based on which features
-- are available
if vim.fn.exists('g:vscode') == 0 then
    vim.cmd([[
        packadd vim-airline
        packadd vim-devicons
        packadd vim-signify
        packadd vim-startify
        packadd vim-tmux-navigator
    ]])

    if vim.fn.has('win32') == 0 then
        vim.cmd('packadd vimux')
        vim.cmd('packadd vimux-cargo')
    end
end

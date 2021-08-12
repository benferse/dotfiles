-- mapleader needs to be set before anything uses it
vim.g.mapleader = " "

-- Extensions that are unnecessary or conflict when using nvim
-- in the context of VSCode. These are generally of the following types:
-- Highlighting
-- Code completion
-- Things that spawn windows or buffers (NERDTree, etc.)
if vim.fn.exists('g:vscode') == 0 then
    vim.cmd([[
        packadd nord-vim
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

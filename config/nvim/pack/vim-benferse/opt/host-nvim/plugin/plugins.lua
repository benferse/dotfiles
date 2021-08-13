-- Load extensions that are only useful when running directly
-- in the nvim host
vim.cmd([[
    packadd plenary.nvim

    packadd nord-vim
    packadd telescope.nvim
    packadd vim-airline
    packadd vim-startify
    packadd vim-tmux-navigator
]])

-- Platform specific plugins
if vim.fn.has('unix') == 1 then
    vim.cmd([[
        packadd vimux
        packadd vimux-cargo
    ]])
end

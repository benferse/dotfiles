-- Load extensions that are only useful when running directly
-- in the nvim host
vim.cmd([[
    packadd nord-vim
    packadd vim-airline
    packadd vim-signify
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

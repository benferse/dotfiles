" Configure any vim or plugin-specific settings before loading plugins
runtime vim-benferse/settings.vimrc

" Load plugins before configuring keymaps to make sure plugins don't override
" any of my defaults
runtime vim-benferse/plugins.vimrc

" My preferred keymaps
runtime vim-benferse/keymaps.vimrc

" Make it pretty!
runtime vim-benferse/theme.vimrc

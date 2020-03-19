" Configure any generic settings before loading plugins
source $HOME/.config/nvim/vim-benferse/settings.vimrc

" Load plugins before configuring keymaps to make sure plugins don't override
" any of my defaults
source $HOME/.config/nvim/vim-benferse/plugins.vimrc

" Load plugin-specific settings
source $HOME/.config/nvim/vim-benferse/plugin-settings.vimrc

" My preferred non-plugin specific keymaps
source $HOME/.config/nvim/vim-benferse/keymaps.vimrc

" Make it pretty!
source $HOME/.config/nvim/vim-benferse/theme.vimrc

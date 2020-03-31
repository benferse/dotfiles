" Configure any generic settings before loading plugins
source $HOME/.config/nvim/vim-benferse/settings.vimrc

" Load plugins before configuring keymaps to make sure plugins don't override
" any of my defaults
source $HOME/.config/nvim/vim-benferse/plugins.vimrc

" Load plugin-specific settings
source $HOME/.config/nvim/vim-benferse/plugin-settings.vimrc

" LSP support is declared separately from other plugin-specific settings, both
" because it can get unwieldy but also to keep the lua in one place
source $HOME/.config/nvim/vim-benferse/lsp.vimrc

" My preferred non-plugin specific keymaps (see the plugin-settings files
" for keymaps that drive individual plugins)
source $HOME/.config/nvim/vim-benferse/keymaps.vimrc

" Make it pretty!
source $HOME/.config/nvim/vim-benferse/theme.vimrc

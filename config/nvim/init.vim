let mapleader="\<space>"

" Load my settings package. This can be done anywhere, since it
" has logic internally to decide whether or not to do things if
" we're in nvim, gvim, VSCode, etc.
packadd benferse-settings

" General purpose extensions that can be loaded no matter
" what context we're running in
packadd vim-beancount
packadd vim-commentary
packadd vim-sneak
packadd vim-surround
packadd vim-textobj-user
packadd vim-textobj-entire
packadd vim-unimpaired

" Extensions that are unnecessary or conflict when using nvim
" in the context of VSCode. These are generally of the following types:
" Highlighting
" Code completion
" Things that spawn windows or buffers (NERDTree, etc.)
if !exists('g:vscode')
    packadd coc.nvim
    packadd fzf
    packadd fzf.vim
    packadd nerdtree
    packadd nord-vim
    packadd vim-airline
    packadd vim-devicons
    packadd vim-fugitive
    packadd vim-ps1
    packadd vim-signify
    packadd vim-startify

    " No tmux on windows
    if !has('win32')
        packadd vim-tmux-navigator
        packadd vimux
        packadd vimux-cargo
    endif
endif

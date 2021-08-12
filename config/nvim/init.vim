let mapleader="\<space>"

" Load my settings package. This can be done anywhere, since it
" has logic internally to decide whether or not to do things if
" we're in nvim, gvim, VSCode, etc.
packadd benferse-settings

" General purpose extensions that can be loaded no matter
" what context we're running in
packadd vim-better-whitespace
packadd vim-commentary
packadd vim-sneak
packadd vim-surround
packadd vim-unimpaired

" Extensions that are unnecessary or conflict when using nvim
" in the context of VSCode. These are generally of the following types:
" Highlighting
" Code completion
" Things that spawn windows or buffers (NERDTree, etc.)
if !exists('g:vscode')
    packadd nord-vim
    packadd vim-airline
    packadd vim-devicons
    packadd vim-signify
    packadd vim-startify
    packadd vim-tmux-navigator

    " No tmux on windows
    if !has('win32')
        packadd vimux
        packadd vimux-cargo
    endif
endif

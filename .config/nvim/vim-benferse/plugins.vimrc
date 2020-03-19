"
" Configuration for plugin management using Shougo/dein.vim
"

"
" Make sure that the dein installation directory is in the runtimepath
"
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    "
    " Make sure dein can manage itself (plugin-ception!)
    "
    call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

    "
    " Managed plugins
    "
    call dein#add('Shougo/defx')
    call dein#add('Shougo/denite')

    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#end()
    call dein#save_state()
endif

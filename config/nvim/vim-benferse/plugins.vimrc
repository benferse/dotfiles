"
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
    call dein#add('Shougo/defx.nvim')
    call dein#add('Shougo/denite.nvim')

    call dein#add('arcticicestudio/nord-vim')

    call dein#add('jreybert/vimagit')

    call dein#add('justinmk/vim-sneak')

    call dein#add('kana/vim-textobj-user')
    call dein#add('kana/vim-textobj-entire')

    call dein#add('kristijanhusak/defx-icons')
    call dein#add('kristijanhusak/defx-git')

    call dein#add('mhinz/vim-signify')
    call dein#add('mhinz/vim-startify')

    call dein#add('neovim/nvim-lsp')

    call dein#add('pprovost/vim-ps1')

    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-unimpaired')

    call dein#add('vim-airline/vim-airline')

    "
    " This needs to be last, evidently. Because reasons
    "
    call dein#add('ryanoasis/vim-devicons')

    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#end()
    call dein#save_state()
endif

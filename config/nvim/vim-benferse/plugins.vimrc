call plug#begin('~/nvim/plugged')
    Plug 'ctrlpvim/ctrlp.vim', { 'as': 'ctrlp' }
    Plug 'scrooloose/nerdtree'
    Plug 'xuyuanp/nerdtree-git-plugin'

    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-entire'
    Plug 'kana/vim-textobj-fold'

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'

    Plug 'easymotion/vim-easymotion'
    Plug 'vim-airline/vim-airline'
    Plug 'justinmk/vim-sneak'

    Plug 'omnisharp/omnisharp-vim'
    Plug 'sirver/ultisnips'
    Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'w0rp/ale'

    Plug 'arcticicestudio/nord-vim'
call plug#end()

"
" deoplete
"
call deoplete#custom#option('sources', {
    \ 'cs': ['omnisharp'],
    \ })

if exists('g:loaded_benferse_settings')
    finish
else
    let g:loaded_benferse_settings = 'yes'
endif

set number
set nowrap
set showmatch

set hidden

set hlsearch
set incsearch
set ignorecase

set autoindent
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set smarttab
set tabstop=4

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
    set scrolloff=1
endif

if !&sidescrolloff
    set sidescrolloff=5
endif

filetype plugin indent on
set autowrite

syntax on
set foldmethod=syntax

"
" python integration settings
"
let g:python_host_prog='d:/master/python37/python.exe'
let g:python3_host_prog='d:/master/python37/python.exe'

"
" deoplete settings
"
let g:deoplete#enable_at_startup=1

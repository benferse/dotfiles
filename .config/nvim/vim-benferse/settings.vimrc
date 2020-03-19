if exists('g:loaded_benferse_settings')
    finish
else
    let g:loaded_benferse_settings = 'yes'
endif

" nvim is always nocompatible, but just in case
if &compatible
    set nocompatible
endif

set number
set relativenumber
set nowrap
set showmatch
set noshowmode
set signcolumn=yes

set cmdheight=1
set noshowcmd
set updatetime=100

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

set nrformats-=octal

set laststatus=2
set ruler
set wildmenu

set shortmess+=cI

let mapleader="\<space>"

if !&scrolloff
    set scrolloff=1
endif

if !&sidescrolloff
    set sidescrolloff=5
endif

filetype plugin indent on
set autowrite

set foldmethod=syntax

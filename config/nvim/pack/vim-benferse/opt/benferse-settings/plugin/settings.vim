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

" vscode-neovim really freaks out if you try to do this
if !exists('g:vscode')
    set relativenumber
    augroup benferse_numbering
        autocmd!
        autocmd InsertEnter * set norelativenumber
        autocmd InsertLeave * set relativenumber
    augroup end
endif

set nowrap
set showmatch
set signcolumn=yes:2

set cmdheight=1
set noshowcmd
set updatetime=100

set hidden
set nobackup
set nowritebackup

set hlsearch
set incsearch
set ignorecase
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.dll

if executable('ag')
    set grepprg=ag\ --nocolor\ --nogroup\ --ignore-case\ --hidden
endif

set autoindent
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set smarttab
set tabstop=4

set nrformats-=octal

set laststatus=2
set noshowmode
set ruler
set wildmenu

set shortmess+=cI

if !&scrolloff
    set scrolloff=1
endif

if !&sidescrolloff
    set sidescrolloff=5
endif

filetype plugin indent on
set autowrite

set foldmethod=syntax

"
" File type detection doesn't do a great job of telling the different between
" json and jsonc (just json, but allows comments). So just highlight comments
" anywhere and assume I'm smart enough to know where they're actually
" supported :|
"
augroup benferse_jsonc
    autocmd FileType json syntax match Comment +\/\/.\+$+
augroup end



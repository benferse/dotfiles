"
" Escape back to normal mode without having to stretch
"
imap jj <esc>
imap jk <esc>
imap kj <esc>

"
" Use <C-L> to clear the highlighting of :set hlsearch.
" Courtesy of the inimitable tpope
"
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent><C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif 

"
" Window management. Having to hit Ctrl-W makes me sad
"
nnoremap <silent><leader>w <C-W>

"
" Use ALT+[h,j,k,l] to move between windows regardless of current mode
"
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

"
" Buffer navigation
"
nnoremap <silent><leader>bn :bnext<CR>
nnoremap <silent><leader>bp :bprevious<CR>
nnoremap <silent><leader>bd :bdelete<CR>

"
" Toggle the help window
"
nnoremap <expr><leader>h benferse#utils#IsHelpOpen() ? ':helpclose<cr>' : ':help '

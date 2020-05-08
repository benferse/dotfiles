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
nnoremap <silent><leader>wh <C-W>h
nnoremap <silent><leader>wj <C-W>j
nnoremap <silent><leader>wk <C-W>k
nnoremap <silent><leader>wl <C-W>l

nnoremap <silent><leader>wo <C-W>o
nnoremap <silent><leader>ws <C-W>s
nnoremap <silent><leader>wv <C-W>v
nnoremap <silent><leader>wn <C-W>n
nnoremap <silent><leader>wq <C-W>c
nnoremap <silent><leader>wc <C-W>c
nnoremap <silent><leader>ww <C-W>w
nnoremap <silent><leader>wt <C-W>t
nnoremap <silent><leader>wb <C-W>b
nnoremap <silent><leader>wr <C-W>r

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

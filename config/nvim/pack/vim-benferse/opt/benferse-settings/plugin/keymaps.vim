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
nnoremap <silent><leader>bn :<C-u> call benferse#buffers#next()<cr>
nnoremap <silent><leader>bp :<C-u> call benferse#buffers#previous()<cr>
nnoremap <silent><leader>bd :<C-u> call benferse#buffers#delete()<cr>

"
" vim-unimpaired sets these, but we want them to go through our smarts instead
" for vscode support
"
nnoremap <silent>]b :<C-u> call benferse#buffers#next()<cr>
nnoremap <silent>[b :<C-u> call benferse#buffers#previous()<cr>
nnoremap <silent>]B :<C-u> call benferse#buffers#last()<cr>
nnoremap <silent>[B :<C-u> call benferse#buffers#first()<cr>

"
" Toggle the help window
"
nnoremap <expr><leader>h benferse#utils#IsHelpOpen() ? ':helpclose<cr>' : ':help '

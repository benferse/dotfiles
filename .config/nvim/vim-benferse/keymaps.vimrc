" Use <C-L> to clear the highlighting of :set hlsearch.
" Courtesy of the inimitable tpope
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif 

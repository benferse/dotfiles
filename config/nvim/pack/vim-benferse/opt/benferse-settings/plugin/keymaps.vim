"
" Escape back to normal mode without having to stretch
"
imap jj <esc>
imap jk <esc>
imap kj <esc>

"
" This is honestly life changing
"
nnoremap ; :<C-u>up<CR>

"
" Use <A-l> to clear the highlighting of :set hlsearch.
" Courtesy of the inimitable tpope, modified for tmux
"
nnoremap <silent><A-l> :nohlsearch<Bar><C-R>=has('diff')?'diffupdate':'mode'<cr><cr>

"
" Window management. Having to hit Ctrl-W makes me sad
"
nnoremap <silent><leader>w <C-W>

"
" Use CTRL+[h,j,k,l] to move between windows regardless of current mode
" We don't allow tmux-navigator to set the normal mode mappings so they
" can be set here all in the same place
"
nnoremap <silent><C-h> :<C-u> call benferse#windows#left()<cr>
nnoremap <silent><C-j> :<C-u> call benferse#windows#down()<cr>
nnoremap <silent><C-k> :<C-u> call benferse#windows#up()<cr>
nnoremap <silent><C-l> :<C-u> call benferse#windows#right()<cr>

inoremap <silent><C-h> <C-\><C-N>:<C-u> call benferse#windows#left()<cr>
inoremap <silent><C-j> <C-\><C-N>:<C-u> call benferse#windows#down()<cr>
inoremap <silent><C-k> <C-\><C-N>:<C-u> call benferse#windows#up()<cr>
inoremap <silent><C-l> <C-\><C-N>:<C-u> call benferse#windows#right()<cr>

tnoremap <silent><C-h> <C-\><C-N>:<C-u> call benferse#windows#left()<cr>
tnoremap <silent><C-j> <C-\><C-N>:<C-u> call benferse#windows#down()<cr>
tnoremap <silent><C-k> <C-\><C-N>:<C-u> call benferse#windows#up()<cr>
tnoremap <silent><C-l> <C-\><C-N>:<C-u> call benferse#windows#right()<cr>

"
" Buffer navigation
"
nnoremap <silent><leader>bn :<C-u> call benferse#buffers#next()<cr>
nnoremap <silent><leader>bp :<C-u> call benferse#buffers#previous()<cr>
nnoremap <silent><leader>bd :<C-u> call benferse#buffers#delete()<cr>

" vim-unimpaired sets these, but we want them to go through our smarts instead
" for vscode support
nnoremap <silent>]b :<C-u> call benferse#buffers#next()<cr>
nnoremap <silent>[b :<C-u> call benferse#buffers#previous()<cr>
nnoremap <silent>]B :<C-u> call benferse#buffers#last()<cr>
nnoremap <silent>[B :<C-u> call benferse#buffers#first()<cr>

"
" Fuzzy finder integration
"
nnoremap <silent><leader>bb :<C-u> call benferse#fuzzy#find_buffers()<cr>
nnoremap <silent><leader>ff :<C-u> call benferse#fuzzy#find_files()<cr>

"
" Traditional find-in-files integration
"
nnoremap <silent><leader>gg :<C-u> call benferse#search#find_in_files()<cr>
nnoremap <silent><leader>g. :<C-u> call benferse#search#find_by_word("<C-R><C-W>")<cr>

"
" Explorer/tree interaction
"
nnoremap <silent><leader>e :<C-u> call benferse#explorer#toggle()<cr>
"
" Toggle the help window
"
nnoremap <expr><leader>h benferse#help#is_open() ? ':helpclose<cr>' : ':help '

"
" Sneaky sneaky
"
if exists('g:sneak#s_next')
    nmap f <Plug>Sneak_f
    nmap F <Plug>Sneak_F
    nmap t <Plug>Sneak_t
    nmap T <Plug>Sneak_T

    xmap f <Plug>Sneak_f
    xmap F <Plug>Sneak_F
    xmap t <Plug>Sneak_t
    xmap T <Plug>Sneak_T

    omap f <Plug>Sneak_f
    omap F <Plug>Sneak_F
    omap t <Plug>Sneak_t
    omap T <Plug>Sneak_T
endif

"
" Recenter on incremental search results
"
nnoremap <silent> n  nzz
nnoremap <silent> N  Nzz
nnoremap <silent> *  *zz
nnoremap <silent> #  #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

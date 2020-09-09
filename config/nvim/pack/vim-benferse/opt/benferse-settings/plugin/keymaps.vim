"
" Escape back to normal mode without having to stretch
"
imap jj <esc>
imap jk <esc>
imap kj <esc>

"
" This is honestly life changing
"
nnoremap ; :<C-u>w<CR>

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
nnoremap <silent><C-h> :<C-u>TmuxNavigateLeft<CR>
nnoremap <silent><C-j> :<C-u>TmuxNavigateDown<CR>
nnoremap <silent><C-k> :<C-u>TmuxNavigateUp<CR>
nnoremap <silent><C-l> :<C-u>TmuxNavigateRight<CR>
nnoremap <silent><C-/> :<C-u>TmuxNavigatePrevious<CR>

inoremap <silent><C-h> <C-\><C-N>:<C-u>TmuxNavigateLeft<CR>
inoremap <silent><C-j> <C-\><C-N>:<C-u>TmuxNavigateDown<CR>
inoremap <silent><C-k> <C-\><C-N>:<C-u>TmuxNavigateUp<CR>
inoremap <silent><C-l> <C-\><C-N>:<C-u>TmuxNavigateRight<CR>
inoremap <silent><C-/> <C-\><C-N>:<C-u>TmuxNavigatePrevious<CR>

tnoremap <silent><C-h> <C-\><C-N>:<C-u>TmuxNavigateLeft<CR>
tnoremap <silent><C-j> <C-\><C-N>:<C-u>TmuxNavigateDown<CR>
tnoremap <silent><C-k> <C-\><C-N>:<C-u>TmuxNavigateUp<CR>
tnoremap <silent><C-l> <C-\><C-N>:<C-u>TmuxNavigateRight<CR>
tnoremap <silent><C-/> <C-\><C-N>:<C-u>TmuxNavigatePrevious<CR>

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

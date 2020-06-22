"
" NERDTree configuration
"
try
    let NERDTreeWinPos='right'
catch
    echo "Error configuring NERDTree - is it installed?"
endtry

"
" Asynccomplete configuration
"
try
    let g:asyncomplete_auto_popup = 1
catch
    echo "Error configuring asyncomplete - is it installed?"
endtry

"
" fzf configuration
"
try
    let g:fzf_layout = { 'window': { 'height': 0.6, 'width': 0.9 } }

    nnoremap <silent><leader>bb :call fzf#vim#buffers({})<CR>
    nnoremap <silent><leader>ff :call fzf#vim#files(getcwd(), { 'options': ['--layout=reverse', '--preview', 'bat {}'] })<CR>
catch
    echo "Error configuring fzf - is it installed?"
endtry

"
" airline configuration
"
try
    let g:airline_powerline_fonts = 1

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamemod = ':t'
catch
    echo 'vim-airline is not installed yet'
endtry

"
" Startify configuration
"
try
    let g:startify_change_to_vcs_root = 1
    let g:startify_files_number = 5
    let g:startify_fortune_use_unicode = 1
catch
    echo 'Error configuring Startify - is it installed?'
endtry

"
" Sneak configuration
"
try
    let g:sneak#s_next = 1
catch
    echo 'Error configuring sneak - is it installed?'
endtry

"
" OmniSharp configuration
"
try
    " Use my own custom proxy that manages standard stream pipes properly
    if has("win32")
        let g:OmniSharp_server_stdio = 1
        let g:OmniSharp_server_path = '~/.local/bin/stdioproxy.exe'
    endif
catch
    echo 'Error configuring OmniSharp - is it installed?'
endtry

"
" Coc configuration
"
try
    " SuperTab-like completion using <tab> for everything -
    " triggering completion, navigating, etc.
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1] =~# '\s'
    endfunction

    " Use Ctrl-Space to trigger completion
    inoremap <silent><expr> <C-Space> coc#refresh()

    " Use <CR> to confirm completion
    if exists('*complete_info')
        inoremap <expr><cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
        inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use ]g and [g to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Code navigation
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in the preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    " Format selected code
    nmap <leader>= <Plug>(coc-format-selected)
    xmap <leader>= <Plug>(coc-format-selected)

    " Declare the function and class text objects
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    nmap if <Plug>(coc-funcobj-i)
    nmap af <Plug>(coc-funcobj-a)
    nmap ic <Plug>(coc-classobj-i)
    nmap ac <Plug>(coc-classobj-a)

    " Try to highlight symbol and references on hover
    autocmd CursorHold * silent call CocActionAsync('highlight')
catch
    echo 'Error configuring CoC - is it installed?'
endtry

" vim:ai fdm=marker

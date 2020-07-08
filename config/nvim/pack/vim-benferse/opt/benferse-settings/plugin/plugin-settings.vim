"
" NERDTree configuration
"

if !exists('g:vscode')
    try
        let NERDTreeWinPos='right'
        nnoremap <silent><leader>e :NERDTreeToggle<CR>
    catch
        echo "Error configuring NERDTree - is it installed?"
    endtry
endif

"
" fzf configuration
"

if !exists('g:vscode')
    try
        let g:fzf_layout = { 'window': { 'height': 0.6, 'width': 0.9 } }

        function! s:build_quickfix_list(lines)
            call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
            copen
            cc
        endfunction

        let g:fzf_action = {
                    \ 'ctrl-t': 'tab split',
                    \ 'ctrl-x': 'split',
                    \ 'ctrl-v': 'vsplit',
                    \ 'ctrl-q': function('s:build_quickfix_list')
                    \ }

        nnoremap <silent><leader>bb :call fzf#vim#buffers({ 'options': '--layout=reverse' })<CR>
        nnoremap <silent><leader>ff :call fzf#vim#files(getcwd(), { 'options': '--layout=reverse --preview="bat {}"'})<CR>
        nnoremap <leader>gg :Ag <C-R><C-W><CR>
        nnoremap <leader>g  :Ag
    catch
        echo "Error configuring fzf - is it installed?"
    endtry
endif

"
" airline configuration
"

if !exists('g:vscode')
    try
        let g:airline_powerline_fonts = 1

        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#fnamemod = ':t'
    catch
        echo 'vim-airline is not installed yet'
    endtry
endif

"
" Startify configuration
"

if !exists('g:vscode')
    try
        let g:startify_change_to_vcs_root = 1
        let g:startify_files_number = 5
        let g:startify_fortune_use_unicode = 1
    catch
        echo 'Error configuring Startify - is it installed?'
    endtry
endif

"
" Sneak configuration
"
try
    let g:sneak#s_next = 1
    let g:sneak#use_ic_scs = 1
    let g:sneak#prompt = 'sneak>'
catch
    echo 'Error configuring sneak - is it installed?'
endtry

"
" Coc configuration
"

if !exists('g:vscode')
    try
        " Force install of the extensions we require
        let g:coc_global_extensions = [
                    \ 'coc-json',
                    \ 'coc-lists',
                    \ 'coc-rust-analyzer',
                    \ 'coc-vimlsp'
                    \ ]

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
        omap if <Plug>(coc-funcobj-i)
        omap af <Plug>(coc-funcobj-a)
        omap ic <Plug>(coc-classobj-i)
        omap ac <Plug>(coc-classobj-a)

        " Code refactoring actions
        nmap <leader>rn <Plug>(coc-rename)
    catch
        echo 'Error configuring CoC - is it installed?'
    endtry
endif

" vim:ai fdm=marker

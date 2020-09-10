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

if !exists('g:vscode')

"
" tmux-navigator configuration
"
try
    " Don't let the plugin set normal mode mappings so they
    " can be kept with other mappings in our keymaps file
    let g:tmux_navigator_no_mappings = 1

    " :update the current buffer when navigating away from a
    " vim window
    let g:tmux_navigator_save_on_switch = 1

    " Disable tmux-navigator when zooming in a vim pane
    let g:tmux_navigator_disable_when_zoomed = 1
catch
    echo "Error configuring tmux-navigator - is it installed?"
endtry

"
" vimux (and plugins)
"
if exists('g:loaded_vimux')

    " Configure the position and appearance of the runner split
    " and the command line prompt
    let g:VimuxHeight = 40
    let g:VimuxOrientation = "h"
    let g:VimuxPromptString = "$ "
    let g:VimuxRunnerType = "pane"

    nmap <silent><leader>vp :<C-u>VimuxPromptCommand<cr>
    nmap <silent><leader>vl :<C-u>VimuxRunLastCommand<cr>
    nmap <silent><leader>vi :<C-u>VimuxInspectRunner<cr>
    nmap <silent><leader>vq :<C-u>VimuxCloseRunner<cr>
    nmap <silent><leader>vs :<C-u>VimuxInterruptRunner<cr>
    nmap <silent><leader>vt :<C-u>VimuxTogglePane<cr>
    nmap <silent><leader>vz :<C-u>VimuxZoomRunner<cr>

    " Using the existence of vimux to map vimux-cargo as well
    nmap <silent><leader>rc :<C-u>CargoRun<cr>
    nmap <silent><leader>rt :<C-u>CargoTestAll<cr>
    nmap <silent><leader>rf :<C-u>CargoUnitTestCurrentFile<cr>
    nmap <silent><leader>r. :<C-u>CargoUnitTestFocused<cr>

endif

"
" NERDTree configuration
"
try
    let NERDTreeWinPos='right'
catch
    echo "Error configuring NERDTree - is it installed?"
endtry

"
" fzf configuration
"
try
    function! s:build_quickfix_list(lines)
        call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
        copen
        cc
    endfunction

    let g:fzf_layout = { 'window': { 'height': 0.6, 'width': 0.9 } }
    let g:fzf_action = {
                \ 'ctrl-t': 'tab split',
                \ 'ctrl-x': 'split',
                \ 'ctrl-v': 'vsplit',
                \ 'ctrl-q': function('s:build_quickfix_list')
                \ }

    nnoremap <leader>gg :Ag <C-R><C-W><CR>
    nnoremap <leader>g  :Ag
catch
    echo "Error configuring fzf - is it installed?"
endtry

"
" airline configuration
"
try
    let g:airline_powerline_fonts = 1

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#tab_nr_type = 1
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
" Coc configuration
"
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

    " Try to highlight symbol and references on hover
    autocmd CursorHold * silent call CocActionAsync('highlight')
catch
    echo 'Error configuring CoC - is it installed?'
endtry

endif

" vim:ai fdm=marker

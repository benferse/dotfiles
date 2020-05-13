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
    nnoremap <silent><leader>ff :call fzf#vim#files(getcwd(), { 'options': ['--layout=reverse', '--info=inline', '--preview', 'bat {}'] })<CR>
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

" vim:ai fdm=marker

" 
" Defx configuration
"
try

catch
    echo 'Defx is not installed yet.'
endtry

"
" Denite configuration
"
try
    call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    call denite#custom#var('buffer', 'date_format', '')

    call denite#custom#option('default', 'split', 'floating')
    call denite#custom#option('default', 'start_filter', 1)
    call denite#custom#option('default', 'auto_resize', 1)
    call denite#custom#option('default', 'source_names', 'short')
    call denite#custom#option('default', 'prompt', 'λ ')
    call denite#custom#option('default', 'highlight_matched_char', 'QuickFixLine')
    call denite#custom#option('default', 'highlight_matched_range', 'Visual')
    call denite#custom#option('default', 'highlight_window_background', 'Visual')
    call denite#custom#option('default', 'highlight_filter_background', 'DiffAdd')
    call denite#custom#option('default', 'winrow', 1)
    call denite#custom#option('default', 'vertical_preview', 1)

    call denite#custom#option('_', 'statusline', v:false)

    "
    " Keybindings for the denite window
    "
    autocmd FileType denite call s:my_denite_settings()
    function! s:my_denite_settings() abort
        nnoremap <silent><buffer><expr> <CR>  denite#do_map('do_action')
        nnoremap <silent><buffer><expr> d     denite#do_map('do_action', 'delete')
        nnoremap <silent><buffer><expr> p     denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
        nnoremap <silent><buffer><expr> q     denite#do_map('quit')
        nnoremap <silent><buffer><expr> <C-o> denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> i     denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'tabopen')
        nnoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
        nnoremap <silent><buffer><expr> <C-s> denite#do_map('do_action', 'vsplit')
    endfunction

    "
    " Keybindings for the denite filter window
    "
    autocmd FileType denite-filter call s:my_denite_filter_settings()
    function! s:my_denite_filter_settings() abort
        imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
        inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
        inoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
        nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
        inoremap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'tabopen')
        inoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
        inoremap <silent><buffer><expr> <C-s> denite#do_map('do_action', 'vsplit')
    endfunction

    "
    " General keybindings to activate denite
    "
    nnoremap <leader>; :Denite buffer<CR>
    nnoremap <leader>f :Denite file/rec<CR>

catch
    echo 'Denite is not installed yet'
endtry

"
" airline configuration
"
try
    let g:airline_powerline_fonts = 1

    let g:airline#extensions#tabline#enabled = 1
catch
    echo 'vim-airline is not installed yet'
endtry

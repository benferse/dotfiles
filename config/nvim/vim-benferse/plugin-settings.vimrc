" 
" Defx configuration
"
try
    autocmd FileType defx call s:my_defx_settings()

    call defx#custom#option('_', {
        \ 'winwidth': 40,
        \ 'columns': 'git:mark:indent:icon:icons:filename',
        \ 'split': 'vertical',
        \ 'direction': 'topleft',
        \ 'show_ignored_files': 1,
        \ 'buffer_name': '',
        \ 'toggle': 1,
        \ 'resume': 1,
        \ 'root_marker': ':'
        \})

    function! s:my_defx_settings() abort "{{{
        setlocal nospell
        setlocal nonumber
        setlocal signcolumn=no
        setlocal cursorline

        nnoremap <silent><buffer><expr> <CR> defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
        nnoremap <silent><buffer><expr> l    defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
        nnoremap <silent><buffer><expr> P    defx#do_action('open', 'pedit')
        nnoremap <silent><buffer><expr> E    defx#do_action('open', 'vsplit')

        nnoremap <silent><buffer><expr> o    defx#do_action('open_or_close_tree')

        nnoremap <silent><buffer><expr> c    defx#do_action('copy')
        nnoremap <silent><buffer><expr> m    defx#do_action('move')
        nnoremap <silent><buffer><expr> p    defx#do_action('paste')
        nnoremap <silent><buffer><expr> d    defx#do_action('remove')
        nnoremap <silent><buffer><expr> r    defx#do_action('rename')

        nnoremap <silent><buffer><expr> yy   defx#do_action('yank_path')
        nnoremap <silent><buffer><expr> .    defx#do_action('toggle_ignored_files')
        nnoremap <silent><buffer><expr> C    defx#do_action('toggle_columns', 'mark:indent:icon:icons:filename')
        nnoremap <silent><buffer><expr> ,    defx#do_action('toggle_select')

        nnoremap <silent><buffer><expr> h    defx#do_action('cd', ['..'])
        nnoremap <silent><buffer><expr> ~    defx#do_action('cd')

        nnoremap <silent><buffer><expr> j    line('.') == line('$') ? 'gg' : 'j'
        nnoremap <silent><buffer><expr> k    line('.') == 1 ? 'G' : 'k'

    endfunction "}}}

    "
    " General keybindings to activate defx
    "
    nnoremap <silent><leader>e :Defx -toggle -split=vertical -winwidth=40 -direction=topleft<CR>

catch
    echo 'Defx is not installed yet.'
endtry

"
" Denite configuration
"
try
	call denite#custom#var('file/rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '--ignore-case', '--hidden', '--ignore', '.git', '-g', ''])

    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
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

    function! s:my_denite_settings() abort "{{{
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
    endfunction "}}}

    "
    " Keybindings for the denite filter window
    "
    autocmd FileType denite-filter call s:my_denite_filter_settings()
    function! s:my_denite_filter_settings() abort "{{{
        imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
        inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
        inoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
        nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
        inoremap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'tabopen')
        inoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
        inoremap <silent><buffer><expr> <C-s> denite#do_map('do_action', 'vsplit')
    endfunction "}}}

    "
    " General keybindings to activate denite
    "
    nnoremap <silent><leader>; :Denite buffer<CR>
    nnoremap <silent><leader>f :Denite file/rec<CR>

catch
    echo 'Denite is not installed yet'
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
    echo 'vim-startify is not installed yet'
endtry

"
" Sneak configuration
"
try
    let g:sneak#s_next = 1
catch
    echo 'vim-sneak is not installed yet'
endtry

" vim:ai fdm=marker

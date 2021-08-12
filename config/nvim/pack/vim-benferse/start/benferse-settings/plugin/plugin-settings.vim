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
" Vim better whitespace
"
try
    let g:better_whitespace_enabled = 1
    let g:strip_whitelines_at_eof = 1
    let g:show_spaces_that_precede_tabs = 1

    nnoremap ]w :NextTrailingWhitespace<cr>
    nnoremap [w :PrevTrailingWhitespace<cr>
catch
    echo 'Error configuring better-whitespace - is it installed?'
endtry

if !exists('g:vscode')

    if !has('win32')
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
            let g:VimuxCloseOnExit = 1

            nmap <silent><leader>vp :<C-u>VimuxPromptCommand<cr>
            nmap <silent><leader>vl :<C-u>VimuxRunLastCommand<cr>
            nmap <silent><leader>vi :<C-u>VimuxInspectRunner<cr>
            nmap <silent><leader>vq :<C-u>VimuxCloseRunner<cr>
            nmap <silent><leader>vs :<C-u>VimuxInterruptRunner<cr>
            nmap <silent><leader>vt :<C-u>VimuxTogglePane<cr>
            nmap <silent><leader>vz :<C-u>VimuxZoomRunner<cr>

            " Using the existence of vimux to map vimux-cargo as well
            " Switch the runner split to the directory of the loaded
            " buffer first
            nmap <silent><leader>rb :<C-u>update <Bar> execute VimuxRunCommand("cd " . expand("%:p:h")) <Bar> CargoBuild<cr>
            nmap <silent><leader>rg :<C-u>update <Bar> execute VimuxRunCommand("cd " . expand("%:p:h")) <Bar> CargoRun<cr>
            nmap <silent><leader>ra :<C-u>update <Bar> execute VimuxRunCommand("cd " . expand("%:p:h")) <Bar> CargoPromptArgs<cr>
            nmap <silent><leader>rt :<C-u>update <Bar> execute VimuxRunCommand("cd " . expand("%:p:h")) <Bar> CargoTestAll<cr>
            nmap <silent><leader>rf :<C-u>update <Bar> execute VimuxRunCommand("cd " . expand("%:p:h")) <Bar> CargoUnitTestCurrentFile<cr>
            nmap <silent><leader>r. :<C-u>update <Bar> execute VimuxRunCommand("cd " . expand("%:p:h")) <Bar> CargoUnitTestFocused<cr>

        endif
    endif

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
        let g:startify_files_number = 7
        let g:startify_fortune_use_unicode = 1
        let g:startify_update_oldfiles = 1

        let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   MRU'] },
            \ { 'type': 'dir',       'header': ['   MRU ' . getcwd()] },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
            \ ]

        let g:startify_bookmarks = [
            \ { 'vr': '~/.config/nvim/init.vim' },
            \ { 'ic': '~/.config/intune/config.toml' },
            \ ]

        nmap <silent><leader>s :<C-u>Startify<cr>
    catch
        echo 'Error configuring Startify - is it installed?'
    endtry

endif " !exists('g:vscode')

" vim:ai fdm=marker

function benferse#fuzzy#find_files()
    if !exists('g:vscode')
        call fzf#vim#files(getcwd(), { 'options': '--layout=reverse --preview="bat {}"'})
    else
        call VSCodeNotify('workbench.action.quickOpen')
    endif
endfunction

function benferse#fuzzy#find_buffers()
    if !exists('g:vscode')
        call fzf#vim#buffers({ 'options': '--layout=reverse' })
    else
        call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')
    endif
endfunction
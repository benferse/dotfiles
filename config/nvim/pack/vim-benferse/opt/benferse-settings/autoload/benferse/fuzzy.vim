function benferse#fuzzy#find_files()
    if !exists('g:vscode')
        " call fzf#vim#files(getcwd(), { 'options': '--layout=reverse --preview="bat {}"'})
	echo nope
    else
        call VSCodeNotify('workbench.action.quickOpen')
    endif
endfunction

function benferse#fuzzy#find_buffers()
    if !exists('g:vscode')
        " call fzf#vim#buffers({ 'options': '--layout=reverse' })
	echo nope
    else
        call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')
    endif
endfunction

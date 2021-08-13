function host#fuzzy#find_files()
    call VSCodeNotify('workbench.action.quickOpen')
endfunction

function host#fuzzy#find_buffers()
    call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')
endfunction

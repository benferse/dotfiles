function host#search#find_in_files()
    call VSCodeNotify('workbench.action.toggleSidebarVisibility')
endfunction

function host#search#find_by_word(word)
    call VSCodeNotify('workbench.action.findInFiles')
endfunction

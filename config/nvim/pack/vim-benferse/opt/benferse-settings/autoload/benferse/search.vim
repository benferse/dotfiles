function benferse#search#find_in_files()
    if !exists('g:vscode')
        Ag
    else
        call VSCodeNotify('workbench.action.toggleSidebarVisibility')
    endif
endfunction

function benferse#search#find_by_word(word)
    if !exists('g:vscode')
        execute "Ag " . expand("<cword>")
    else
        call VSCodeNotify('workbench.action.findInFiles')
    endif
endfunction

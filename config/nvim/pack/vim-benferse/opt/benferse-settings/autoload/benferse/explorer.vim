function benferse#explorer#toggle()
    if !exists('g:vscode')
        CocCommand explorer --toggle --position right
    else
        call VSCodeNotify('workbench.action.toggleSidebarVisibility')
    endif
endfunction

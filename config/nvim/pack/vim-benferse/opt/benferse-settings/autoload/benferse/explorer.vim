function benferse#explorer#toggle()
    if !exists('g:vscode')
    	echo nope
    else
        call VSCodeNotify('workbench.action.toggleSidebarVisibility')
    endif
endfunction

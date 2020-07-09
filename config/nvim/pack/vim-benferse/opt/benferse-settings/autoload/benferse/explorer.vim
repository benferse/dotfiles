function benferse#explorer#toggle()
    if !exists('g:vscode')
        NERDTreeToggle
    else
        call VSCodeNotify('workbench.action.toggleSidebarVisibility')
    endif
endfunction

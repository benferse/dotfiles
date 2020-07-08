function benferse#buffers#next()
    if !exists('g:vscode')
        bnext
    else
        Tabnext
    endif
endfunction

function benferse#buffers#previous()
    if !exists('g:vscode')
        bprev
    else
        Tabprevious
    endif
endfunction

function benferse#buffers#delete()
    if !exists('g:vscode')
        bdelete
    else
        Tabclose
    endif
endfunction

function benferse#buffers#first()
    if !exists('g:vscode')
        bfirst
    else
        Tabfirst
    endif
endfunction

function benferse#buffers#last()
    if !exists('g:vscode')
        blast
    else
        Tablast
    endif
endfunction
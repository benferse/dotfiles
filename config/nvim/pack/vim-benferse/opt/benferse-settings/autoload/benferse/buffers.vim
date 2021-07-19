function benferse#buffers#any_listed()
    let s:buffs = getbufinfo({'buflisted': 1})
    return !empty(s:buffs)
endfunction

function benferse#buffers#next()
    if !exists('g:vscode')
        if benferse#buffers#any_listed()
            bnext
        endif
    else
        Tabnext
    endif
endfunction

function benferse#buffers#previous()
    if !exists('g:vscode')
        if benferse#buffers#any_listed()
            bprev
        endif
    else
        Tabprevious
    endif
endfunction

function benferse#buffers#first()
    if !exists('g:vscode')
        if benferse#buffers#any_listed()
            bfirst
        endif
    else
        Tabfirst
    endif
endfunction

function benferse#buffers#last()
    if !exists('g:vscode')
        if benferse#buffers#any_listed()
            blast
        endif
    else
        Tablast
    endif
endfunction

function benferse#buffers#delete() abort
    if !exists('g:vscode')
        bdelete
    else
        Tabclose
    endif
endfunction

function benferse#buffers#really_delete() abort
    if !exists('g:vscode')
        bd!
    else
        Tabclose
    endif
endfunction

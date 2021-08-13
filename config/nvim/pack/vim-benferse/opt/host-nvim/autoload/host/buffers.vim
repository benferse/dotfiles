function host#buffers#any_listed()
    let s:buffs = getbufinfo({'buflisted': 1})
    return !empty(s:buffs)
endfunction

function host#buffers#next()
    if host#buffers#any_listed()
        bnext
    endif
endfunction

function host#buffers#previous()
    if host#buffers#any_listed()
        bprev
    endif
endfunction

function host#buffers#first()
    if host#buffers#any_listed()
        bfirst
    endif
endfunction

function host#buffers#last()
    if host#buffers#any_listed()
        blast
    endif
endfunction

function host#buffers#delete() abort
    bdelete
endfunction

function host#buffers#really_delete() abort
    bd!
endfunction

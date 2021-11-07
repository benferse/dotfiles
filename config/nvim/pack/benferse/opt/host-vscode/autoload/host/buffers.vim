function host#buffers#next()
    Tabnext
endfunction

function host#buffers#previous()
    Tabprevious
endfunction

function host#buffers#first()
    Tabfirst
endfunction

function host#buffers#last()
    Tablast
endfunction

function host#buffers#delete() abort
    Tabclose
endfunction

function host#buffers#really_delete() abort
    Tabclose
endfunction

function host#buffers#new() abort
    Enew
endfunction

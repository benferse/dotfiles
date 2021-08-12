"
" Determines whether there is a visible windows that is currently
" displaying a help buffer
"
function benferse#help#is_open()
    for buf in getbufinfo({"buflisted": 0, "bufloaded": 1, "bufmodified": 0})
        if getbufvar(buf.bufnr, '&buftype') == 'help' && !buf.hidden
            return 1
        endif
    endfor
    return 0
endfunction

function benferse#windows#left()
    if exists('$TMUX')
        TmuxNavigateLeft
    endif
endfunction

function benferse#windows#right()
    if exists('$TMUX')
        TmuxNavigateRight
    endif
endfunction

function benferse#windows#up()
    if exists('$TMUX')
        TmuxNavigateUp
    endif
endfunction

function benferse#windows#down()
    if exists('$TMUX')
        TmuxNavigateDown
    endif
endfunction

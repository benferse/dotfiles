"
" The Tmux* commands are clever enough to do the right thing even
" if you're not inside tmux, which is nice
"

function host#windows#left()
    TmuxNavigateLeft
endfunction

function host#windows#right()
    TmuxNavigateRight
endfunction

function host#windows#up()
    TmuxNavigateUp
endfunction

function host#windows#down()
    TmuxNavigateDown
endfunction

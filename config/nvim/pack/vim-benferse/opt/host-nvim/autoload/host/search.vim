function host#search#find_in_files()
    lua require('telescope.builtin').live_grep()
endfunction

function host#search#find_by_word()
    lua require('telescope.builtin').grep_string()
endfunction

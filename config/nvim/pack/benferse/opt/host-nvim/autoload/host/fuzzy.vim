function host#fuzzy#find_files()
    lua require('telescope.builtin').find_files()
endfunction

function host#fuzzy#find_buffers()
    lua require('telescope.builtin').buffers()
endfunction

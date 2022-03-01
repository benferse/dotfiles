local M = {}

M.in_files = function() require('telescope.builtin').live_grep() end
M.by_word  = function() require('telescope.builtin').grep_string() end

return M

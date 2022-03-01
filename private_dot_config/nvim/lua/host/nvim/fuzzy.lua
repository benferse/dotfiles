local M = {}

M.files   = function() require('telescope.builtin').find_files()   end
M.buffers = function() require('telescope.builtin').find_buffers() end

return M

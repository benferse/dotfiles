local M = {}

M.files    = function() require('telescope.builtin').find_files() end
M.buffers  = function() require('telescope.builtin').buffers() end
M.recent   = function() require('telescope.builtin').oldfiles() end
M.projects = function() vim.cmd[[Telescope projects]] end

return M

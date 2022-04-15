local M = {}

M.left  = function() vim.cmd[[wincmd h]] end
M.down  = function() vim.cmd[[wincmd j]] end
M.up    = function() vim.cmd[[wincmd k]] end
M.right = function() vim.cmd[[wincmd l]] end
M.close = function() vim.cmd[[wincmd c]] end
M.only  = function() vim.cmd[[wincmd o]] end

return M

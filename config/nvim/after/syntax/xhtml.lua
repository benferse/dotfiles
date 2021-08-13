local cmd = vim.cmd
local setlocal = vim.opt_local

--
-- I like having folds available, but I generally want a newly
-- opened file to have all folds opened, so let's do that.
--

setlocal.foldmethod = 'syntax'
cmd([[normal zR]])

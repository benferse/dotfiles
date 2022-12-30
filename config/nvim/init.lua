--
-- init.lua is the moral equivalent of init.vim. It is sourced before
-- anything else from the runtimepath, so here is where we setup anything
-- we want other plugins to see from the get go
--
-- See ':help startup' for more info on initialization order
--

--
-- The vim module is always made available from nvim, so there's no
-- need to import it directly. But it's idiomatic to have local references
-- to its more interesting exports
--
-- See ':help lua-vimscript' for general information about the lua <-> vimscript
-- bridge, and ':help lua-vim-variables' for the other predefined global tables
-- (like 'b:', 'w:', etc.)
--

--
-- mapleader needs to be set before anything uses it
--
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

require('config.settings')
require('config.lazy')

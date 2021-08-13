local augroup = require('utils').augroup
local set = vim.opt

--
-- Auto switching between absolute and relative line numbering
--
set.number = true
set.relativenumber = true

numbering = {
    [[InsertEnter * set norelativenumber]],
    [[InsertLeave * set relativenumber]]
}

augroup('benferse#numbering', numbering, true)

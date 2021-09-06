-- Global settings and vim options that aren't set in
-- the top level init.lua since they are host specific
local augroup = require('utils').augroup

-- Auto switching between absolute and relative line numbering,
-- but only if the buffer hasn't explicitly turned off
-- numbering
vim.opt.number = true
vim.opt.relativenumber = true

local numbering = {
    [[InsertEnter * if &l:number | set norelativenumber | end]],
    [[InsertLeave * if &l:number | set relativenumber | end]]
}

augroup('benferse#numbering', numbering, true)

-- Use a slightly shorter timeout length than the default
-- so the which-key menu will appear in a more timely manner
vim.opt.timeoutlen = 500

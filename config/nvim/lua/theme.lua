--
-- Colors / fonts / pretty things
--

local cmd = vim.cmd
local set = vim.opt

local function setup()
    set.termguicolors = true
    set.background = 'dark'

    cmd([[colorscheme nord]])
end

return { setup = setup }

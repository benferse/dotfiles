--
-- Colors / fonts / pretty things
--

local cmd = vim.cmd
local g = vim.g
local set = vim.opt

local function setup()
    set.termguicolors = true
    set.background = 'dark'

    g.nord_bold = 1
    g.nord_italic = 1
    g.nord_italic_comments = 1
    g.nord_underline = 1

    cmd([[colorscheme nord]])
end

return { setup = setup }

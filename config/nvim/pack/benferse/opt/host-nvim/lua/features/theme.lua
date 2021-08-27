-- Color scheme, and general appearance

local function setup(args)
    vim.cmd([[
        packadd nord-vim
        packadd nvim-web-devicons
    ]])

    vim.opt.termguicolors = true
    vim.opt.background = 'dark'

    vim.g.nord_bold = 1
    vim.g.nord_italic = 1
    vim.g.nord_italic_comments = 1
    vim.g.nord_underline = 1

    vim.cmd([[colorscheme nord]])
end

return { setup = setup }

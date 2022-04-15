--
-- Try to load our default theme, but fallback to something
-- sensible in case that doesn't work out
--
vim.cmd [[
    try
        set termguicolors
        set background=dark

        let g:nord_bold = 1
        let g:nord_italic = 1
        let g:nord_italic_comments = 1
        let g:nord_underline = 1

        colorscheme nord
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
        set background=dark
    endtry
]]

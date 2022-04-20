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

vim.cmd [[
    highlight default GitGutterAdd ctermfg=2 guifg=#A3BE8C
    highlight default GitGutterChange ctermfg=3 guifg=#EBCB8B
    highlight default GitGutterDelete ctermfg=1 guifg=#BF616A
]]
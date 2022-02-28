--
-- Try to load our default theme, but fallback to something
-- sensible in case that doesn't work out
--
vim.cmd [[
    try
        colorscheme nord
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
        set background=dark
    endtry
]]

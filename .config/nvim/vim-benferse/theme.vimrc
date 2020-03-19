"
" Colorscheme and other pretty things
"

if (has("termguicolors"))
    set termguicolors
endif

set background=dark

try
    colorscheme nord
catch
    colorscheme default
endtry

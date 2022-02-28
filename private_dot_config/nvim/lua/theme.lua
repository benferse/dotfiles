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

--
-- Use custom diagnostic sign text and highlights that are consistent with other
-- plugins in our current theme
--
vim.cmd [[
    highlight! default link DiagnosticError LspDiagnosticsDefaultError
    highlight! default link DiagnosticHint LspDiagnosticsDefaultHint
    highlight! default link DiagnosticInfo LspDiagnosticsDefaultInformation
    highlight! default link DiagnosticInformation LspDiagnosticsDefaultInformation
    highlight! default link DiagnosticWarn LspDiagnosticsDefaultWarning
    highlight! default link DiagnosticWarning LspDiagnosticsDefaultWarning

    highlight! default link DiagnosticUnderlineError LspDiagnosticsUnderlineError
    highlight! default link DiagnosticUnderlineHint LspDiagnosticsUnderlineHint
    highlight! default link DiagnosticUnderlineInfo LspDiagnosticsUnderlineInformation
    highlight! default link DiagnosticUnderlineWarn LspDiagnosticsUnderlineWarning
]]

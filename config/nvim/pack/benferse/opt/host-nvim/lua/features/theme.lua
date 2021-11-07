-- Color scheme, and general appearance

local function setup()
    vim.cmd([[
        packadd lspkind-nvim
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

    -- Link a few plugin specific highlight definitions to
    -- default groups that nord has kindly setup for us
    vim.cmd([[
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
    ]])

    require('lspkind').init {}
end

return { setup = setup }

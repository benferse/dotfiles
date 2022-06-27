local is_ok, bufferline = pcall(require, 'bufferline')
if not is_ok then
    return
end

bufferline.setup {
    options = {
        diagnostics = 'nvim_lsp',
        enforce_regular_tabs = true,
        separator_style = 'slant',
        offsets = {
            {
                filetype = 'neo-tree',
                text = 'File Explorer',
                highlight = 'Directory',
                text_align = 'left',
            },
            {
                filetype = 'aerial',
                text = 'Symbols',
                highlight = 'Directory',
                text_align = 'right',
            }
        }
    }
}

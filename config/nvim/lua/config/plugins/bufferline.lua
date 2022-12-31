local M = {
    "akinsho/nvim-bufferline.lua",
    event = "BufAdd",
}

function M.config()
    require("bufferline").setup({
        options = {
            always_show_bufferline = false,
            show_close_icon = true,
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
    })
end

return M

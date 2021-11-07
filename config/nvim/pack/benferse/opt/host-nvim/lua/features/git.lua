-- Source control, diff and merge tools, and surfacing git
-- information in the ui

local function setup()
    vim.cmd([[
        packadd diffview.nvim
        packadd gitsigns.nvim
    ]])

    require('diffview').setup {}

    require('gitsigns').setup {
        preview_config = {
            border = 'rounded',
        },
        signs = {
            add = { hl = 'GitGutterAdd', text = '+' },
            change = { hl = 'GitGutterChange', text = '~' },
            delete = { hl = 'GitGutterDelete', text = '_' },
            topdelete = { hl = 'GitGutterDelete', text = '‾' },
            changedelete = { hl = 'GitGutterChange', text = '~' },
        },
    }
end

return { setup = setup }

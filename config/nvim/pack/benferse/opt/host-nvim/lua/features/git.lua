-- Source control, diff and merge tools, and surfacing git
-- information in the ui

local M = {}

M.setup = function(args)
    vim.cmd([[
        packadd diffview.nvim
        packadd gitsigns.nvim
        packadd neogit
    ]])

    require('diffview').setup {}

    require('gitsigns').setup {
        signs = {
            add = { hl = 'GitGutterAdd', text = '+' },
            change = { hl = 'GitGutterChange', text = '~' },
            delete = { hl = 'GitGutterDelete', text = '_' },
            topdelete = { hl = 'GitGutterDelete', text = '‾' },
            changedelete = { hl = 'GitGutterChange', text = '~' },
        },
    }

    require('neogit').setup {
        integrations = {
            diffview = true,
        },
    }
end

return M

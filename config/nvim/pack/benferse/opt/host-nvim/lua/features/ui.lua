-- User interface elements that drive the overall display,
-- appearance, and layout

local map = require('utils').map

local function setup(args)
    vim.cmd([[
        packadd dashboard-nvim
        packadd lualine.nvim
        packadd nord-vim
        packadd nvim-web-devicons
        packadd nvim-bufferline
        packadd which-key.nvim
    ]])

    vim.g.dashboard_executive = 'telescope'
    vim.g.dashboard_custom_footer = {}
    vim.g.dashboard_custom_header = {
        '███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
        '████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
        '██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
        '██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
        '██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
        '╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
    }

    require('bufferline').setup {
        options = {
            diagnostics = 'nvim_lsp',
            enforce_regular_tabs = true,
            separator_style = 'slant',
        }
    }

    local function my_lsp_status()
        return require('lsp-status').status()
    end

    require('lualine').setup {
        options = {
            theme = 'nord',
        },
        sections = {
            lualine_c = { 'filename', my_lsp_status },
        },
    }

    local which_key = require('which-key')
    which_key.setup {
        window = {
            border = 'none',
            position = 'bottom',
        },
        triggers = 'auto',
        triggers_blacklist = {
            i = { 'j', 'k' },
            v = { 'j', 'k' },
        },
    }

    which_key.register  {
        ["<leader>b"] = {
            name = "Buffers",
            n = "Next",
            p = "Previous",
            d = "Hide",
            x = "Wipeout",
        },
    }
end

return { setup = setup }

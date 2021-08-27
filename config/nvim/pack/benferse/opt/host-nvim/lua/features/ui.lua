-- User interface elements that drive the overall display,
-- appearance, and layout

local map = require('utils').map

local function setup(args)
    vim.cmd([[
        packadd dashboard-nvim
        packadd lualine.nvim
        packadd nvim-bufferline
        packadd project.nvim
    ]])

    vim.g.dashboard_executive = 'telescope'
    vim.g.dashboard_custom_footer = { 'https://github.com/benferse' }
    vim.g.dashboard_custom_header = {
        '███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
        '████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
        '██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
        '██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
        '██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
        '╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
    }
    vim.g.dashboard_custom_section = {
        section_0 = {
            description = { ' Recent sessions        *' },
            command = 'Telescope projects',
        },
        section_1 = {
            description = { ' Find a file            *' },
            command = 'Telescope find_files',
        },
        section_2 = {
            description = { ' Recent files           *' },
            command = 'Telescope oldfiles',
        },
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

    require('project_nvim').setup {}
end

return { setup = setup }

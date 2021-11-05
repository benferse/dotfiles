-- User interface elements that drive the overall display,
-- appearance, and layout

local function window_number()
    return vim.api.nvim_win_get_number(0)
end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local function setup()
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
        section_3 = {
            description = { ' Empty buffer           *' },
            command = 'DashboardNewFile',
        }
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
        extensions = {
            'nvim-tree', 'quickfix', 'toggleterm',
        },
        options = {
            theme = 'nord',
        },
        sections = {
            lualine_a = { window_number },
            lualine_b = {
                { 'b:gitsigns_head', icon = '', },
                { 'diff', source = diff_source },
            },
            lualine_c = { 'filename', my_lsp_status },
        },
    }

    require('project_nvim').setup {}
end

return { setup = setup }

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
        packadd lualine-lsp-progress
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
            description = { ' Recent sessions        <SPC> f s' },
            command = 'Telescope projects',
        },
        section_1 = {
            description = { ' Find a file            <SPC> f f' },
            command = 'Telescope find_files',
        },
        section_2 = {
            description = { ' Recent files           <SPC> f r' },
            command = 'Telescope oldfiles',
        },
        section_3 = {
            description = { ' Empty buffer           <SPC> b e' },
            command = 'DashboardNewFile',
        },
        section_4 = {
            description = { ' Source control         <SPC> t g' },
            command = 'lua toggle_git_window()',
        },
        section_5 = {
            description = { ' Quit                   :qall<cr>'},
            command = 'qall!'
        }
    }

    require('bufferline').setup {
        options = {
            diagnostics = 'nvim_lsp',
            enforce_regular_tabs = true,
            separator_style = 'slant',
        }
    }

    require('lualine').setup {
        extensions = {
            'nvim-tree', 'quickfix', 'toggleterm',
        },
        options = {
            theme = 'nord',
        },
        sections = {
            lualine_a = { window_number, 'mode', },
            lualine_b = {
                { 'filename', icon = '', },
            },
            lualine_c = {
                {
                    'lsp_progress',
                    icon = '理',
                    fmt = function(data) return string.sub(data, 1, vim.o.columns / 2) end,
                    display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
                    spinner_symbols = { '', '', '', '', '', '', '', '', },
                },
            },
            lualine_x = {},
            lualine_y = {
                { 'b:gitsigns_head', icon = '', },
                { 'diff', source = diff_source, icon = '' },
                { 'diagnostics', source = 'nvim_diagnostic' },
            },
        },
    }

    require('project_nvim').setup {}
end

return { setup = setup }

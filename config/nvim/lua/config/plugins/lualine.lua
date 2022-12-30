local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "smiteshp/nvim-navic",
    },
    event = "VeryLazy",
}

local function breadcrumbs()
    local navic = require("nvim-navic")
    if navic.is_available() then
        return navic.get_location()
    end

    return [[]]
end

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

function M.config()
    require("lualine").setup({
        extensions = {
            'quickfix',
            'toggleterm',
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
                { breadcrumbs, },
            },
            lualine_x = {},
            lualine_y = {
                { 'b:gitsigns_head', icon = '', },
                { 'diff', source = diff_source, icon = '' },
                { 'diagnostics', source = 'nvim_diagnostic' },
            },
        },
        inactive_sections = {
            lualine_a = { window_number },
        }
    })
end

return M

-- Plugins that enhance the layout of the editor, window/buffer/tab/status chrome,
-- and other UI elements

local function window_number()
    return vim.api.nvim_win_get_number(0)
end

return {
    -- Bufferline / winline
    {
        "akinsho/bufferline.nvim",
        event = "BufAdd",
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                enforce_regular_tabs = true,
                separator_style = "slant",
                offset = {
                    {
                        filetype = "neo-tree",
                        text = "File explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
        keys = {
            { "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Buffer" } },
            { "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer" } },

            { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { desc = "Buffer" } },
            { "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer" } },

            { "H", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer" } },
            { "L", "<cmd>BufferLineCycleNext<cr>", { desc = "Buffer" } },
        },
    },
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "smiteshp/nvim-navic",
        },
        config = function()
            require("lualine").setup({
                extensions = {
                    "quickfix",
                    "toggleterm",
                },
                options = {
                    theme = "auto",
                },
                sections = {
                    lualine_a = { window_number, "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        { "diagnostics" },
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { "filename", path = 1 },
                        { require("nvim-navic").get_location, require("nvim-navic").is_available },
                    },
                    lualine_x = {},
                    lualine_y = {},
                },
                inactive_sections = {
                    lualine_a = { window_number },
                },
            })
        end,
    },
    -- Prettier replacement for vim.notify
    {
        "rcarriga/nvim-notify",
        keys = {
            { "<leader>nd", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Clear notifications" },
        },
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },
    -- Prettier vim.ui.select and vim.ui.input
    {
        "stevearc/dressing.nvim",
        init = function()
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" }})
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" }})
                return vim.ui.input(...)
            end
        end,
    },
    -- Prettier replacements for cmdline, notifications, and messages
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
            },
            messages = {
                enabled = true,
                view = "notify",
                view_error = "notify",
                view_warn = "notify",
                view_history = "messages",
                view_search = "virtualtext",
            },
            popupmenu = {
                enabled = true,
                backend = "nui",
            },
            notify = {
                enabled = true,
                view = "notify",
            },
        },
    },
}

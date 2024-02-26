-- Navigation panels (file explorer, project navigation, etc)

return {
    -- Tree view file explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        branch = "v2.x",
        dependencies = {
            "muniftanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {
                "<leader>ve",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = require("benvim").get_root() })
                end,
                desc = "Explorer",
            },
        },
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
        end,
        opts = {
            filesystem = {
                follow_current_file = true,
                hijack_netrw_behavior = "open_current",
            },
            renderer = {
                icons = {
                    glyphs = {
                        git = {
                            unstaged = "X",
                            untracked = "Z",
                        },
                    },
                },
            },
            window = {
                mappings = {
                    ["<space>"] = false,
                    ["P"] = { "toggle_preview", config = { use_float = true } },
                },
            },
        },
    },
    -- Folke's improved quickfix / loclist / generic list of navigable diagnostic-like things
    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        opts = { use_diagnostic_signs = true },
        keys = {
            {
                "]x",
                function()
                    require("trouble").next({ skip_groups = true, jump = true })
                end,
                desc = "Trouble",
            },
            {
                "[x",
                function()
                    require("trouble").previous({ skip_groups = true, jump = true })
                end,
                desc = "Trouble",
            },
            {
                "]X",
                function()
                    require("trouble").last({ skip_groups = true, jump = true })
                end,
                desc = "Trouble",
            },
            {
                "[X",
                function()
                    require("trouble").first({ skip_groups = true, jump = true })
                end,
                desc = "Trouble",
            },
            { "<leader>vx", "<cmd>TroubleToggle<cr>",                       desc = "Trouble" },
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document diagnostics" },
            { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace diagnostics" },
            { "<leader>xx", "<cmd>TroubleToggle<cr>",                       desc = "Open/Close" },
        },
    },
    -- Tracking the location of TODO/BUG/README/FIX etc. style comments across the project
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "BufReadPost",
        config = true,
        keys = {
            {
                "]t",
                function()
                    require("todo-comments").jump_next()
                end,
                desc = "Todo comment",
            },
            {
                "[t",
                function()
                    require("todo-comments").jump_prev()
                end,
                desc = "Todo comment",
            },
            { "<leader>xs", "<cmd>TodoTelescope<cr>",      desc = "Telescope: Todo comments" },
            { "<leader>xt", "<cmd>TroubleToggle todo<cr>", desc = "Trouble: Todo comments" },
        },
    },
    -- Document outline, drawing from multiple context-sensitive sources
    {
        "stevearc/aerial.nvim",
        cmd = { "AerialNext", "AerialPrev", "AerialToggle" },
        opts = {
            attach_mode = "global",
            backends = { "lsp", "treesitter", "markdown", "man" },
            layout = { min_width = 28 },
            show_guides = true,
            filter_kind = false,
            guides = {
                mid_item = "├ ",
                last_item = "└ ",
                nested_top = "│ ",
                whitespace = "  ",
            },
        },
        keys = {
            {
                "]y",
                function()
                    require("aerial").next()
                end,
                desc = "Symbol",
            },
            {
                "[y",
                function()
                    require("aerial").prev()
                end,
                desc = "Symbol",
            },
            {
                "]Y",
                function()
                    require("aerial").next_up()
                end,
                desc = "Symbol",
            },
            {
                "[Y",
                function()
                    require("aerial").prev_up()
                end,
                desc = "Symbol",
            },
            { "<leader>vs", "<cmd>AerialToggle!<cr>", desc = "Symbols" },
        },
    },
}

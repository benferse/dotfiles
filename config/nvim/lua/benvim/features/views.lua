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
            { "<leader>ve", function() require("neo-tree.command").execute( { toggle = true, dir = require("benvim").get_root() } ) end, desc = "Explorer" },
        },
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
        end,
        opts = {
            filesystem = {
                follow_current_file = true,
                hijack_netrw_behavior = "open_current",
            },
            window = {
                mappings = {
                    ["<space>"] = false,
                },
            },
        },
    },
    -- Folke's improved quickfix / loclist / generic list of navigable diagnostic-like things
    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle", },
        opts = { use_diagnostic_signs = true },
        keys = {
            { "<leader>vx", "<cmd>TroubleToggle<cr>", desc = "Toggle trouble view" },
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document diagnostics" },
            { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace diagnostics" },
            { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Open/Close" },
        },
    },
    -- Tracking the location of TODO/BUG/README/FIX etc. style comments across the project
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "BufReadPost",
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Todo comment" },
            { "<leader>xs", "<cmd>TodoTelescope<cr>", desc = "Todo comments" },
            { "<leader>xt", "<cmd>TroubleToggle todo<cr>", desc = "Todo comments" },
        },
    },
    -- Document outline, drawing from multiple context-sensitive sources
    {
        "stevearc/aerial.nvim",
        cmd = { "AerialNext", "AerialPrev", "AerialToggle" },
        config = true,
        keys = {
            { "]a", "<cmd>AerialNext<cr>", "Symbol (Aerial)" },
            { "[a", "<cmd>AerialPrev<cr>", "Symbol (Aerial)" },
            { "<leader>vs", "<cmd>AerialToggle!<cr>", "Symbols / outline" },
        }
    },
}

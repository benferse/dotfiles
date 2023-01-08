-- Fundamental plugins that are either depended on by or used across multiple
-- other plugins

return {
    -- The plugin manager is capable of keeping itself up to date as long
    -- as it has been bootstrapped once
    "folke/lazy.nvim",

    -- Common lua functions library published by the neovim folks but
    -- not included in the base product
    "nvim-lua/plenary.nvim",

    -- Standard icon pack
    "nvim-tree/nvim-web-devicons",

    -- which-key is loaded here so we can have a single place to define all
    -- of the key group names
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.setup({
                plugins = {
                    spelling = true,
                    marks = true,
                    registers = true,
                },
                key_labels = {
                    ["<leader>"] = "SPC",
                },
                disable = {
                    buftypes = {},
                    filetypes = { "TelescopePrompt", "neo-tree" },
                },
            })
            wk.register({
                mode = {"n", "v"},
                ["g"] = "+Goto",
                ["z"] = "+Junk drawer",
                ["]"] = "+Next",
                ["["] = "+Previous",
                ["<leader>"] = "More...",
                ["<localleader>"] = "More...",
                ["<leader>b"] = "+Buffer",
                ["<leader>f"] = "+File",
                ["<leader>g"] = "+Git",
                ["<leader>h"] = "+Help",
                ["<leader>l"] = "+Lazy",
                ["<leader>n"] = "+Notifications",
                ["<leader>s"] = "+Search",
                ["<leader>v"] = "+View",
                ["<leader>w"] = "+Window",
            })
        end,
    },
}

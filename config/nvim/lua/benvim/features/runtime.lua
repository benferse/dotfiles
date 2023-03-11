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

    -- Neovim plugin/extension development, which is also quite nice for editing
    -- our own config
    "folke/neodev.nvim",

    -- Empower `.` to repeat more than just built in commands
    "tpope/vim-repeat",

    -- which-key is loaded here so we can have a single place to define all
    -- of the key group names
    {
        "benferse/which-key.nvim",
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
                window = {
                    align = "right",
                    position = "bottom",
                    border = "rounded",
                    width = function()
                        return math.floor(vim.o.columns * 0.4)
                    end,
                },
                layout = {
                    height = { min = 99 },
                },
            })
            wk.register({
                mode = { "n", "v" },
                ["g"] = "+Goto",
                ["z"] = "+Junk drawer",
                ["]"] = "+Next",
                ["["] = "+Previous",
                ["<leader>"] = "Benvim (global)",
                ["<localleader>"] = "Benvim (local)",
                ["<leader>b"] = "+Buffer",
                ["<leader>c"] = "+Code",
                ["<leader>f"] = "+File",
                ["<leader>g"] = "+Git",
                ["<leader>h"] = "+Help",
                ["<leader>n"] = "+Notifications",
                ["<leader>q"] = "+Quit",
                ["<leader>s"] = "+Search",
                ["<leader>t"] = "+Toggle",
                ["<leader>u"] = "+Plugins/Updates",
                ["<leader>v"] = "+View",
                ["<leader>w"] = "+Window",
                ["<leader>x"] = "+Issues",
                ["<leader><Tab>"] = "+Tabs",
            })
        end,
    },
}

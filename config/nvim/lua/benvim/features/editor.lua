return {
    -- Add indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        main = "ibl",
        opts = {
            indent = { char = "│" },
            exclude = {
                buftypes = { "alpha", "help", "neo-tree", "Trouble", "lazy", "mason" },
            },
        },
    },
    -- active indent guide and indent text objects
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = "BufReadPre",
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "alpha", "help", "neo-tree", "Trouble", "lazy", "mason" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
            require("mini.indentscope").setup({
                symbol = "│",
                options = { try_as_border = true },
            })
        end,
    },
    -- Highlight matching references under the cursor
    {
        "rrethy/vim-illuminate",
        event = "BufReadPost",
        config = function()
            require("illuminate").configure({ delay = 200 })
        end,
        keys = {
            {
                "]]",
                function()
                    require("illuminate").goto_next_reference(true)
                end,
                desc = "Highlighted word",
            },
            {
                "[[",
                function()
                    require("illuminate").goto_prev_reference(true)
                end,
                desc = "Highlighted word",
            },
        },
    },
    -- Smart buffer remove without messing with window layouts
    {
        "echasnovski/mini.bufremove",
        keys = {
            {
                "<leader>bd",
                function()
                    require("mini.bufremove").delete(0, false)
                end,
                desc = "Delete",
            },
            {
                "<leader>bx",
                function()
                    require("mini.bufremove").delete(0, true)
                end,
                desc = "Force delete",
            },
        },
    },
    -- Navigation
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        dependencies = {
            {
                "ggandor/flit.nvim",
                opts = {
                    labeled_modes = "nv",
                },
            },
        },
        config = function(_, opts)
            local leap = require("leap")
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
        end,
    },
    {
        "echasnovski/mini.surround",
        keys = { "," },
        opts = {
            mappings = {
                add = ",a",
                delete = ",d",
                replace = ",r",
            },
        },
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end,
    },
    {
        "folke/twilight.nvim",
        event = "VeryLazy",
        config = true,
        keys = {
            { "<leader>tw", "<cmd>Twilight<cr>", "Twilight" },
        },
    },
    {
        "folke/zen-mode.nvim",
        cmd = { "ZenMode" },
        event = "VeryLazy",
        opts = {
            window = {
                width = 0.75,
            },
            plugins = {
                twilight = true,
                kitty = {
                    enabled = true,
                    font = "+4",
                },
            },
        },
        keys = {
            { "<leader>tz", "<cmd>ZenMode<cr>", "Zen mode" },
        },
    },
}

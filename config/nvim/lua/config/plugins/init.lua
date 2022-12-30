return {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",

    {
        "nvim-tree/nvim-web-devicons",
        config = {
            default = true,
        },
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        config = {
            auto_open = false,
            use_diagnostic_signs = true,
        },
    },

    "folke/twilight.nvim",
    "folke/which-key.nvim",

    "williamboman/mason-lspconfig.nvim",

    {
        "numtostr/comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "arcticicestudio/nord-vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme nord]]
        end,
    },
}

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
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end,
    },

    "folke/twilight.nvim",
    "williamboman/mason-lspconfig.nvim",
    "famiu/bufdelete.nvim",

    {
        "numtostr/comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end
    },
    {
        "arcticicestudio/nord-vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.nord_bold = 1
            vim.g.nord_italic = 1
            vim.g.nord_italic_comments = 1
            vim.g.nord_underline = 1

            vim.cmd [[
                set termguicolors
                set background=dark
                colorscheme nord
            ]]
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.code_actions.gitsigns,
                },
            })
        end
    },
}

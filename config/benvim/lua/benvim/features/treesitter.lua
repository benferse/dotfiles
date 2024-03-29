-- Treesitter configuration

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function()
            -- lua_ls is a little to overzealous here
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
                sync_install = false,
                ensure_installed = {
                    "bash",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "regex",
                    "rust",
                    "vim",
                },
                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<cr>",
                        node_incremental = "<cr>",
                        scope_incremental = "<S-cr>",
                        node_decremental = "<BS>",
                    },
                },
                indent = {
                    enable = true,
                },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        event = "BufEnter",
        config = function(_, opts)
            require("treesitter-context").setup(opts)

            vim.cmd([[
                highlight link TreesitterContext PmenuSel
            ]])
        end,
        keys = {
            { "<leader>tc", "<cmd>TSContextToggle<cr>", "Treesitter context" },
        },
    },
}

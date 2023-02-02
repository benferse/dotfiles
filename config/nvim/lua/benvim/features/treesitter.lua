-- Treesitter configuration

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function()
            require("nvim-treesitter.configs").setup({
                sync_install = false,
                ensure_installed = {
                    "bash",
                    "help",
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
    -- Additional text objects based on treesitter syntax elements
    {
        "echasnovski/mini.ai",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        event = "BufEnter",
        opts = {
            mappings = {
                goto_left = "[g",
                goto_right = "]g",
            },
            n_lines = 10000,
            search_method = "cover",
        },
        config = function(_, opts)
            local ai = require("mini.ai")
            local ts = ai.gen_spec.treesitter

            opts.custom_textobjects = {
                F = ts({
                    a = "@function.outer",
                    i = "@function.inner",
                }),
                o = ts({
                    a = {
                        "@conditional.outer",
                        "@loop.outer",
                    },
                    i = {
                        "@conditional.inner",
                        "@loop.inner",
                    },
                }),
            }

            ai.setup(opts)
        end,
    }
}

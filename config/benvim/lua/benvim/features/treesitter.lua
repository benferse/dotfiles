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
                    "rust",
                },
                highlight = {
                    enable = true,
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
}

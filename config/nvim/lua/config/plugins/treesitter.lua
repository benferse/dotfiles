return {
    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",
    event = "BufReadPost",

    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "lua",
                "rust",
                "toml",
                "vim",
                "yaml",
            },
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,
            },
            indent = {
                enable = false,
            },
        })
    end,
}

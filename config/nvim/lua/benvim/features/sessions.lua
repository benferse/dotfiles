return {
    {
        "ahmedkhalf/project.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            manual_mode = false,
            detection_methods = {
                "lsp",
                "pattern",
            },
        },
        config = function(_, opts)
            require("project_nvim").setup(opts)
            require("telescope").load_extension("projects")
        end,
        keys = {
            {
                "<leader>fp",
                function()
                    require("telescope").extensions.projects.projects({})
                end,
                desc = "Projects",
            },
        },
    },
}

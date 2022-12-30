return {
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-ui-select.nvim",

    cmd = { "Telescope" },

    config = function()
        require("telescope").setup({
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                winblend = 10,
                mappings = {
                    i = {
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-t>'] = to_trouble,
                        ['<esc>'] = actions.close,
                        ['jj'] = actions.close,
                        ['jk'] = actions.close,
                        ['kj'] = actions.close,
                    },
                    n = {
                        ['<C-t>'] = function(...)
                            return require("trouble.providers.telescope").open_with_trouble(...)
                        end,
                    },
                },
            },
            extensions = {
                ['ui-select'] = { require('telescope.themes').get_dropdown { } }
            }
        })

        telescope.load_extension('ui-select')
    end
}

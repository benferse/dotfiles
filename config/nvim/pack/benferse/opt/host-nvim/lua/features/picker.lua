-- File browsers, fuzzy finders, explorers, searching.
-- All the fun stuff to find something to operate on.

local map = require('utils').map

local M = {}

M.setup = function(args)
    vim.cmd([[
        packadd telescope.nvim
        packadd nvim-tree.lua
    ]])

    local actions = require('telescope.actions')

    require('telescope').setup {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            winblend = 10,
            mappings = {
                i = {
                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-k>'] = actions.move_selection_previous,
                    ['<esc>'] = actions.close,
                    ['jj'] = actions.close,
                    ['jk'] = actions.close,
                    ['kj'] = actions.close,
                },
            },
        },
    }

    --
    -- Cool, thanks @allizon!
    --
    local function find_nvim_config()
        require("telescope.builtin").find_files {
            cwd = "~/.config/nvim",
            prompt_title = "nvim config",
        }
    end

    map('n', '<leader>vf', '<cmd>lua find_nvim_config()<cr>')

    vim.g.nvim_tree_side = 'right'
    vim.g.nvim_tree_width = 40
    vim.g.nvim_tree_gitignore = 1
    vim.g.nvim_tree_auto_close = 1
end

return M

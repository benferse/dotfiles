-- File browsers, fuzzy finders, explorers, searching.
-- All the fun stuff to find something to operate on.

local map = require('utils').map

local function setup()
    vim.cmd([[
        packadd nvim-cmp
        packadd cmp-nvim-lsp
        packadd telescope.nvim
        packadd nvim-tree.lua
    ]])

    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup {
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

    telescope.load_extension('projects')

    -- Cool, thanks @allizon!
    local function find_nvim_config()
        require("telescope.builtin").find_files {
            cwd = "~/.config/nvim",
            prompt_title = "nvim config",
        }
    end

    map('n', '<leader>vf', '<cmd>lua find_nvim_config()<cr>')

    local tree = require('nvim-tree');
    tree.setup {
        auto_close = true,
        view = {
            side = 'right',
            width = 40,
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
    }

    vim.g.nvim_tree_gitignore = 1
    vim.g.nvim_tree_respect_buf_cwd = 1

    -- Autocompletion
    local cmp = require('cmp')
    cmp.setup {
        sources = cmp.config.sources {
            { name = 'nvim_lsp' },
        },
        mapping = {
            ['<cr>'] = cmp.mapping.confirm({ select = true }),
        }
    }
end

return { setup = setup }

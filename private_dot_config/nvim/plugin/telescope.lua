-- Telescope for fuzzy finding all the things

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
    extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown { } }
    }
}

telescope.load_extension('projects')
telescope.load_extension('ui-select')

-- Telescope for fuzzy finding all the things

local telescope = require('telescope')
local actions = require('telescope.actions')

local has_trouble, trouble = pcall(require, 'trouble.providers.telescope')

local function to_trouble(a, b)
    if has_trouble then
        -- Use the same binding for open selected or open
        -- all if none are selected
        trouble.smart_open_with_trouble(a, b)
    end
end

telescope.setup {
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
                ['<C-t>'] = to_trouble,
            },
        },
    },
    extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown { } }
    }
}

telescope.load_extension('projects')
telescope.load_extension('ui-select')

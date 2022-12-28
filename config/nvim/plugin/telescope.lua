local is_ok, telescope = pcall(require, 'telescope')
if not is_ok then
    return
end

local is_ok, actions = pcall(require, 'telescope.actions')
if not is_ok then
    return
end

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

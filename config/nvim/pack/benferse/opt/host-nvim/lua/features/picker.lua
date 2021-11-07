-- File browsers, fuzzy finders, explorers, searching.
-- All the fun stuff to find something to operate on.

local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function feedkey(key, mode)
    local x = vim.api.nvim_replace_termcodes(key, true, true, true)
    vim.api.nvim_feedkeys(x, mode, true)
end

local function setup()
    vim.cmd([[
        packadd nvim-cmp
        packadd cmp-nvim-lsp
        packadd vim-vsnip
        packadd cmp-vsnip
        packadd telescope.nvim
        packadd nvim-tree.lua
    ]])

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
    }

    telescope.load_extension('projects')

    -- nvim-tree, because sometimes you just want a file explorer

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

    -- Something about this makes the lua lsp pretty upset
    ---@diagnostic disable-next-line: redundant-parameter
    cmp.setup {
        sources = cmp.config.sources {
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
        },
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        mapping = {
            ['<cr>'] = cmp.mapping({
                i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, }),
                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            }),
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),

            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif vim.fn["vsnip#available"](1) == 1 then
                    feedkey("<Plug>(vsnip-expand-or-jump)", "")
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                    feedkey("<Plug>(vsnip-jump-prev)", "")
                else
                    fallback()
                end
            end, { "i", "s" }),
        }
    }
end

return { setup = setup }

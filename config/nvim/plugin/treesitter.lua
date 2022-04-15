require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'json', 'lua', 'rust', 'toml', 'vim' },
    highlight = { enable = true, },
    incremental_selection = { enable = true, },

    -- Treesitter indent isn't quite mature enough. Rely on
    -- language plugins instead for now
    indent = { enable = false, },

    -- Syntax aware text objects
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['ac'] = [[@class.outer]],
                ['ic'] = [[@class.inner]],
                ['af'] = [[@function.outer]],
                ['if'] = [[@function.inner]],
            }
        },
        move = {
            enable = true,
            set_jumps = true,

            goto_next_start = {
                [']m'] = [[@function.outer]],
                [']]'] = [[@class.outer]],
            },

            goto_next_end = {
                [']M'] = [[@function.outer]],
                [']['] = [[@class.outer]],
            },

            goto_previous_start = {
                ['[m'] = [[@function.outer]],
                ['[['] = [[@class.outer]],
            },

            goto_previous_end = {
                ['[M'] = [[@function.outer]],
                ['[]'] = [[@class.outer]],
            },
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
                ['<leader>lp'] = [[@function.outer]],
                ['<leader>lc'] = [[@class.outer]],
            }
        }
    }
}

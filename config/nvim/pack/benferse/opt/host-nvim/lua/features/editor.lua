-- Plugins and modifications to the core text editing
-- experience, and isn't that really why we're here in
-- the first place?

local map = require('utils').map

local function check_back_space()
    local col = vim.fn.col '.' - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
        return true
    else
        return false
    end
end

function tab_complete()
    if vim.fn.pumvisible() == 1 then
        return vim.api.nvim_replace_termcodes('<C-n>', true, true, true)
    elseif check_back_space() then
        return vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
    else
        return vim.fn['compe#complete']()
    end
end

function s_tab_complete()
    if vim.fn.pumvisible() == 1 then
        return vim.api.nvim_replace_termcodes('<C-p>', true, true, true)
    else
        return vim.api.nvim_replace_termcodes('<S-Tab>', true, true, true)
    end
end

local function setup(args)
    vim.cmd([[
        packadd nvim-compe
        packadd nvim-autopairs
        packadd nvim-comment
    ]])

    require('nvim_comment').setup {}

    require('compe').setup {
        documentation = {
            border = 'rounded',
        };
        source = {
            path = true,
            buffer = true,
            nvim_lsp = true,
        };
    }

    vim.opt.completeopt = 'menuone,noinsert,noselect'

    map({'i', 's'}, '<Tab>', 'v:lua.tab_complete()', { expr = true })
    map({'i', 's'}, '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
    map('i', '<C-Space>', 'compe#complete()', { expr = true })

    require('nvim-autopairs').setup {
        disable_filetype = { 'TelescopePrompt' },
    }

    require('nvim-autopairs.completion.compe').setup {
        map_cr = true,
        map_complete = true,
        auto_seelct = false,
    }

end

return { setup = setup }

-- User interface elements that drive the overall display,
-- appearance, and layout

local map = require('utils').map

local function setup(args)
    vim.cmd([[
        packadd lualine.nvim
        packadd nord-vim
        packadd nvim-web-devicons
        packadd nvim-bufferline
        packadd vim-startify
        packadd which-key.nvim
    ]])

    require('bufferline').setup {
        options = {
            diagnostics = 'nvim_lsp',
            enforce_regular_tabs = true,
            separator_style = 'slant',
        }
    }

    local function my_lsp_status()
        return require('lsp-status').status()
    end

    require('lualine').setup {
        options = {
            theme = 'nord',
        },
        sections = {
            lualine_c = { 'filename', my_lsp_status },
        },
    }

    vim.g.startify_change_to_vcs_root = 1
    vim.g.startify_files_number = 7
    vim.g.startify_fortune_use_unicode = 1
    vim.g.startify_update_oldfiles = 1

    map('n', '<leader>s', [[:<C-u>Startify<cr>]], { silent = true })

    require('which-key').setup {
        window = {
            border = 'none',
            position = 'bottom',
        },
        triggers = 'auto',
        triggers_blacklist = {
            i = { 'j', 'k' },
            v = { 'j', 'k' },
        },
    }
end

return { setup = setup }

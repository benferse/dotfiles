-- User interface elements that drive the overall display,
-- appearance, and layout

local map = require('utils').map

local M = {}

M.setup = function(args)
    vim.cmd([[
        packadd nord-vim
        packadd nvim-web-devicons
        packadd nvim-bufferline
        packadd vim-startify
        packadd lualine.nvim
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

    map('n', '<leader>s', [[:<C-u>Startify<cr>]], silent)
end

return M

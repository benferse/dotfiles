--
-- Load extensions that are only useful when running directly
-- in the nvim host
--
local cmd = vim.cmd
local g = vim.g
local has = vim.fn.has
local map = require('utils').map
local set = vim.opt
local silent = { silent = true }

--
-- Generally useful libraries, global stuff without dependencies, and
-- so forth
--
vim.cmd([[
    packadd plenary.nvim
    packadd nord-vim
]])

--
-- Airline
--
vim.cmd([[packadd vim-airline]])

g.airline_powerline_fonts = 1
g['airline#extensions#tabline#enabled'] = 1
g['airline#extensions#tabline#tab_nr_type'] = 1
g['airline#extensions#tabline#fnamemod'] = ':t'

--
-- Gitsigns
--
vim.cmd([[packadd gitsigns.nvim]])

require('gitsigns').setup {
    signs = {
        add = { hl = 'GitGutterAdd', text = '+' },
        change = { hl = 'GitGutterChange', text = '~' },
        delete = { hl = 'GitGutterDelete', text = '_' },
        topdelete = { hl = 'GitGutterDelete', text = '‾' },
        changedelete = { hl = 'GitGutterChange', text = '~' },
    },
}

--
-- Startify
--
vim.cmd([[packadd vim-startify]])

g.startify_change_to_vcs_root = 1
g.startify_files_number = 7
g.startify_fortune_use_unicode = 1
g.startify_update_oldfiles = 1

map('n', '<leader>s', [[:<C-u>Startify<cr>]], silent)

--
-- Telescope
--
vim.cmd([[packadd telescope.nvim]])

local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        path_display = {
            'shorten',
        },
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
-- Tmux navigator
--
vim.cmd([[packadd vim-tmux-navigator]])

g.tmux_navigator_save_on_switch = 1
g.tmux_navigator_disable_when_zoomed = 1
if has('win32') == 0 then
    g.tmux_navigator_no_mappings = 1
end

--
-- Native neovim LSP configuration.
--
vim.cmd([[packadd nvim-lspconfig]])

local lspconfig = require('lspconfig')
local on_attach = function(_, bufnum)
    vim.api.nvim_buf_set_option(bufnum, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnum, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', silent)
    vim.api.nvim_buf_set_keymap(bufnum, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', silent)
    vim.api.nvim_buf_set_keymap(bufnum, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>', silent)
    vim.api.nvim_buf_set_keymap(bufnum, 'n', '<LocalLeader>k', '<cmd>lua vim.lsp.buf.signature_help()<cr>', silent)

    vim.api.nvim_buf_set_keymap(bufnum, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', silent)
end

lspconfig['rust_analyzer'].setup {
    on_attach = on_attach,
}

set.completeopt = 'menuone,noselect'

--
-- nvim-compe for completion
--
vim.cmd([[packadd nvim-compe]])

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

local function check_back_space()
    local col = vim.fn.col '.' - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return vim.api.nvim_replace_termcodes('<C-n>', true, true, true)
    elseif check_back_space() then
        return vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return vim.api.nvim_replace_termcodes('<C-p>', true, true, true)
    else
        return vim.api.nvim_replace_termcodes('<S-Tab>', true, true, true)
    end
end

map({'i', 's'}, '<Tab>', 'v:lua.tab_complete()', { expr = true })
map({'i', 's'}, '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
map('i', '<C-Space>', 'compe#complete()', { expr = true })

--
-- nvim-autopairs
--
vim.cmd([[packadd nvim-autopairs]])

require('nvim-autopairs').setup {
    disable_filetype = { 'TelescopePrompt' },
}

require('nvim-autopairs.completion.compe').setup {
    map_cr = true,
    map_complete = true,
    auto_seelct = false,
}

--
-- Plugins for places where tmux is likelier to exist
--
if has('unix') == 1 or has('mac') then
    vim.cmd([[
        packadd vimux
        packadd vimux-cargo
    ]])

    g.VimuxHeight = 40
    g.VimuxOrientation = 'h'
    g.VimuxPromptString = '$'
    g.VimuxRunnerType = 'pane'
    g.VimuxCloseOnExit = 1

    map('n', '<leader>vp', [[:<C-u>VimuxPromptCommand<cr>]], silent)
    map('n', '<leader>vq', [[:<C-u>VimuxCloseRunner<cr>]], silent)
    map('n', '<leader>vs', [[:<C-u>VimuxInterruptRunner<cr>]], silent)
    map('n', '<leader>vt', [[:<C-u>VimuxTogglePane<cr>]], silent)
    map('n', '<leader>vz', [[:<C-u>VimuxZoomRunner<cr>]], silent)

    map('n', '<leader>rb', [[:<C-u>update <Bar> execute VimuxRunCommand("cd " . expand("%:p:h")) <Bar> CargoBuild<cr>]], silent)
    map('n', '<leader>rg', [[:<C-u>update <Bar> execute VimuxRunCommand("cd " . expand("%:p:h")) <Bar> CargoRun<cr>]], silent)
    map('n', '<leader>rt', [[:<C-u>update <Bar> execute VimuxRunCommand("cd " . expand("%:p:h")) <Bar> CargoTestAll<cr>]], silent)
end

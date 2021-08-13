--
-- Load extensions that are only useful when running directly
-- in the nvim host
--
local cmd = vim.cmd
local g = vim.g
local has = vim.fn.has
local map = require('utils').map
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

g.airline_powerline_fonts = 1
g['airline#extensions#tabline#enabled'] = 1
g['airline#extensions#tabline#tab_nr_type'] = 1
g['airline#extensions#tabline#fnamemod'] = ':t'

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

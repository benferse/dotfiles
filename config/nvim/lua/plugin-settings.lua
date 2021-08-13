local g = vim.g
local has = vim.fn.has
local map = require('utils').map
local silent = { silent = true }

local function setup()
    --
    -- Sneak configuration
    --
    g['sneak#s_next'] = 1
    g['sneak#use_ic_scs'] = 1
    g['sneak#prompt'] = 'sneak> '

    --
    -- Vim better whitespace
    --
    g.better_whitespace_enabled = 1
    g.strip_whitelines_at_eof = 1
    g.show_spaces_that_precede_tabs = 1

    map('n', ']w', ':NextTrailingWhitespace<cr>')
    map('n', '[w', ':PrevTrailingWhitespace<cr>')

    --
    -- Tmux navigator configuration
    --
    if has('win32') == 0 then
        g.tmux_navigator_no_mappings = 1
        g.tmux_navigator_save_on_switch = 1
        g.tmux_navigator_disable_when_zoomed = 1
    end

    --
    -- Vimux and its extensions
    --
    if g.loaded_vimux ~= nil then
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

    --
    -- Airline configuration
    --
    g.airline_powerline_fonts = 1
    g['airline#extensions#tabline#enabled'] = 1
    g['airline#extensions#tabline#tab_nr_type'] = 1
    g['airline#extensions#tabline#fnamemod'] = ':t'

    --
    -- Startify configuration
    --
    g.startify_change_to_vcs_root = 1
    g.startify_files_number = 7
    g.startify_fortune_use_unicode = 1
    g.startify_update_oldfiles = 1

    map('n', '<leader>s', [[:<C-u>Startify<cr>]], silent)
end

return { setup = setup }

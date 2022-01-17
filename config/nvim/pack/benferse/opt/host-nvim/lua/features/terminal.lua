-- Integration between nvim, integrated terminals, and any
-- terminal emulators that it's running in

local map = require('utils').map;

local git_window = {}

local function setup()
    vim.cmd([[
        packadd vim-tmux-navigator
        packadd toggleterm.nvim
    ]])

    vim.g.tmux_navigator_save_on_switch = 1
    vim.g.tmux_navigator_disable_when_zoomed = 1
    if vim.fn.has('win32') == 0 then
        vim.g.tmux_navigator_no_mappings = 1
    end

    require('toggleterm').setup {
        open_mapping = [[g<cr>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = false,
        persist_size = true,
        direction = 'vertical',
        size = function(term)
            if term.direction == 'horizontal' then
                return 15
            elseif term.direction == 'vertical' then
                return vim.o.columns * 0.4
            end
        end,
        close_on_exit = true,
    }

    git_window = require('toggleterm.terminal').Terminal:new({
        cmd = 'lazygit',
        dir = 'git_dir',
        direction = 'float',
        float_opts = {
            border = 'rounded',
        },
    })

    let wk = require("which-key")

    wk.register({
        't' = {
            name = 'terminal',
            g = { '<cmd>lua toggle_git_window()<cr>', 'lazygit' },
        },
    }, { prefix = "<leader>" })

end

function _G.toggle_git_window()
    git_window:toggle()
end

return { setup = setup }

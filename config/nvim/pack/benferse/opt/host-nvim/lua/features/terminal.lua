-- Integration between nvim, integrated terminals, and any
-- terminal emulators that it's running in

local map = require('utils').map;

local terminals = {}

local function add_terminal(command, name, shortcut)
     terminals[shortcut] = require('toggleterm.terminal').Terminal:new({
	    cmd = command,
	    dir = 'git_dir',
        direction = 'float',
    })

    map('n', '<leader>t'..shortcut, '<cmd>lua Terminal_toggle_window("'..shortcut..'")<cr>', name)
end

function Terminal_toggle_window(shortcut)
    local term = terminals[shortcut]
    if term ~= nil then
        term:toggle()
    end
end

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
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = false,
        persist_size = true,
        direction = 'float',
        size = function(term)
            if term.direction == 'horizontal' then
                return 15
            elseif term.direction == 'vertical' then
                return vim.o.columns * 0.4
            end
        end,
        close_on_exit = true,
        float_opts = {
            border = 'rounded',
        }
    }

    add_terminal('lazygit', 'lazygit', 'g')
    add_terminal('ranger', 'ranger', 'r')
    add_terminal('htop', 'htop', 't')

    -- Add an explicit mapping to close a floating terminal
    -- window quickly
    map('t', '<C-Space>', '<C-\\><C-N>ZQ')

end

return { setup = setup }

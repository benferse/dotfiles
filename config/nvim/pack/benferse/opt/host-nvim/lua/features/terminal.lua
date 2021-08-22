-- Integration between nvim, integrated terminals, and any
-- terminal emulators that it's running in

local function setup(args)
    vim.cmd([[
        packadd vim-tmux-navigator
    ]])

    vim.g.tmux_navigator_save_on_switch = 1
    vim.g.tmux_navigator_disable_when_zoomed = 1
    if vim.fn.has('win32') == 0 then
        vim.g.tmux_navigator_no_mappings = 1
    end
end

return { setup = setup }

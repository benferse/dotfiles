local M = {}

local has_toggleterm, tt = pcall(require, 'toggleterm.terminal')
local has_dap_ui, dapui = pcall(require, 'dapui')

local terminals = {}

local function toggle(cmd)
    if has_toggleterm then
        local term = terminals[cmd]

        if term == nil then
            term = tt.Terminal:new({
                cmd = cmd,
                dir = 'git_dir',
                direction = 'float',
            })

            terminals[cmd] = term
        end

        if term ~= nil then
            term:toggle()
        end
    end
end

M.git = function()
    toggle('lazygit')
end

M.explorer = function()
    toggle('ranger')
end

M.profiler = function()
    toggle('htop')
end

M.debugger = function()
    if has_dap_ui then dapui.toggle() end
end

return M

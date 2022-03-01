local M = {}

local has_toggleterm, tt = pcall(require, 'toggleterm.terminal')
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

return M

local M = {}

local has_dap_ui, dapui = pcall(require, 'dapui')

local terminals = {}

local function toggle(cmd)
    local term = terminals[cmd]

    if term == nil then
        term = require("toggleterm.terminal").Terminal:new({
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

M.git = function()
    toggle('lazygit')
end

M.explorer = function()
    vim.cmd [[Neotree position=left toggle=true reveal=true source=filesystem]]
end

M.markdown = function()
    toggle('mdless '..vim.fn.expand('%:p'))
end

M.profiler = function()
    toggle('btop')
end

M.debugger = function()
    if has_dap_ui then dapui.toggle() end
end

M.symbols = function()
    vim.cmd [[AerialToggle! right]]
end

return M

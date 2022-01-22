--
-- Debugging support via [DAP](https://microsoft.github.io/debug-adapter-protocol/)
-- and adapters for languages I debug often
--

local map = require('utils').map

local function setup()
    vim.cmd([[
        packadd nvim-dap
        packadd nvim-dap-ui
    ]])

    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
    end

    dap.listeners.after.event_terminated['dapui_config'] = function()
        dapui.close()
    end

    dap.listeners.after.event_exited['dapui_config'] = function()
        dapui.close()
    end

    map('n', '<F5>', '<cmd>lua require("dap").continue()<cr>')

    map('n', '<F9>',    '<cmd>lua require("dap").toggle_breakpoint()<cr>')
    map('n', '<S-F9>',  '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<cr>')
    map('n', '<F10>',   '<cmd>lua require("dap").step_over()<cr>')
    map('n', '<F11>',   '<cmd>lua require("dap").step_into()<cr>')
    map('n', '<S-F11>', '<cmd>lua require("dap").step_out()<cr>')

end

return { setup = setup }

-- Debugging support

local function setup()
    vim.cmd([[
        packadd nvim-dap
    ]])

    local dap = require('dap')
    dap.configurations.cpp = {
        {
            cwd = '${workspaceFolder}',
            stopOnEntry = true
        }
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

end

return { setup = setup }

local has_dap, dap = pcall(require, 'dap')
if not has_dap then
    return
end

local has_dap_ui, dapui = pcall(require, 'dapui')
if not has_dap_ui then
    return
end

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

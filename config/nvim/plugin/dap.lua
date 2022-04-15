local has_dap, dap = pcall(require, 'dap')
if not has_dap then
    return
end

local has_dap_ui, dapui = pcall(require, 'dapui')
if not has_dap_ui then
    return
end

dapui.setup()

dap.listeners.after.event_initialized['dapui'] = function()
    dapui.open()
end

dap.listeners.after.event_terminated['dapui'] = function()
    dapui.close()
end

dap.listeners.after.event_exited['dapui'] = function()
    dapui.close()
end

-- Doesn't work after 0.7 :(
-- dap.defaults.fallback.terminal_win_cmd = [[belowright new +let\ b:dap_terminal\ =\ 1]]
-- vim.cmd (
--     [[autocmd TermClose * try                                    |]]..
--     [[  call nvim_buf_get_var(eval(expand('<abuf>')), 'dap_terminal') |]]..
--     [[  exec 'bd! ' . expand('<abuf>')                                |]]..
--     [[catch | endtry                                                   ]]
-- )

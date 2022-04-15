local M = {}

M.toggle = function()
    for _, buf in pairs(vim.fn.getbufinfo()) do
        if vim.fn.getbufvar(buf.bufnr, '&buftype') == 'help' and buf.hidden == 0 then
            -- There is already a help buffer shown in a window, so close it
            vim.cmd [[helpclose]]
            return
        end
    end

    vim.cmd [[Telescope help_tags]]
end

return M

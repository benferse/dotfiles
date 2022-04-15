local is_ok, notify = pcall(require, 'notify')
if not is_ok then
    return
end

-- Use notify as the default notification funcion
vim.notify = notify

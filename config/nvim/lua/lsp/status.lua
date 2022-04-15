local is_ok, lsp_status = pcall(require, 'lsp-status')
if not is_ok then
    return
end

lsp_status.register_progress()

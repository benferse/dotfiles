local is_ok, trouble = pcall(require, 'trouble')
if not is_ok then
    return
end

trouble.setup {
    auto_close = true,
    auto_preview = true,
    use_diagnostic_signs = true,
}

vim.cmd [[
    augroup trouble_window_config
        autocmd!
        autocmd FileType Trouble setlocal cursorline
    augroup END
]]

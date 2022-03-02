local is_ok, trouble = pcall(require, 'trouble')
if not is_ok then
    return
end

trouble.setup {
    auto_close = true,
    use_diagnostic_signs = true,
}

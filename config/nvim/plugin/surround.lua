local is_ok, surround = pcall(require, 'surround')
if not is_ok then
    return
end

surround.setup {
    load_keymaps = false,
}

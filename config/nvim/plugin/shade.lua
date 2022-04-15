local is_ok, shade = pcall(require, 'shade')
if not is_ok then
    return
end

shade.setup {
    overlay_opacity = 50,
    opacity_step = 1,
}

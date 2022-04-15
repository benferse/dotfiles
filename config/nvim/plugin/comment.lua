local is_ok, comment = pcall(require, 'Comment')
if not is_ok then
    return
end

comment.setup {
    padding = true,
    sticky = true,
}

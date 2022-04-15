local is_ok, outline = pcall(require, 'symbols-outline')
if not is_ok then
    return
end

outline.setup({})

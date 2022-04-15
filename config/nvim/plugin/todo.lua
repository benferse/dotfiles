local is_ok, todo = pcall(require, 'todo-comments')
if not is_ok then
    return
end

todo.setup {}

local is_ok, project = pcall(require, 'project_nvim')
if not is_ok then
    return
end

project.setup {}

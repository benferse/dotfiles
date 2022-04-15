local M = {}

--local has_bufdelete, bufdelete = pcall(require, 'bufdelete')

local function any_listed()
    local buffs = vim.fn.getbufinfo({ buflisted = 1 })
    return next(buffs) ~= nil
end

-- local function do_delete(force)
--     if has_bufdelete then
--         bufdelete.bufdelete(0, force)
--     else
--         local suffix = force and '!' or ''
--         vim.cmd('bdelete'..suffix)
--     end
-- end

M.next = function() if any_listed() then vim.cmd('Tabnext') end end
M.previous = function() if any_listed() then vim.cmd('Tabprevious') end end
M.first = function() if any_listed() then vim.cmd('Tabfirst') end end
M.last = function() if any_listed() then vim.cmd('Tablist') end end
M.delete = function() vim.cmd('Tabclose') end
M.really_delete = function() vim.cmd('Tabclose') end

M.new = function()
    vim.cmd([[
        Enew
        startinsert
    ]])
end

return M

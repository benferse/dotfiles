local M = {}

local has_bufdelete, bufdelete = pcall(require, 'bufdelete')

local function any_listed()
    local buffs = vim.fn.getbufinfo({ buflisted = 1 })
    return next(buffs) ~= nil
end

local function do_delete(force)
    if has_bufdelete then
        bufdelete.bufdelete(0, force)
    else
        local suffix = force and '!' or ''
        vim.cmd('bdelete'..suffix)
    end
end

M.next = function() if any_listed() then vim.cmd('bnext') end end
M.previous = function() if any_listed() then vim.cmd('bprev') end end
M.first = function() if any_listed() then vim.cmd('bfirst') end end
M.last = function() if any_listed() then vim.cmd('blast') end end
M.delete = function() do_delete(false) end
M.really_delete = function() do_delete(true) end

M.new = function()
    vim.cmd([[
        enew
        startinsert
    ]])
end

return M

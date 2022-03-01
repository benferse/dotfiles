local M = {}

local function any_listed()
    local buffs = vim.fn.getbufinfo({ buflisted = 1 })
    return next(buffs) ~= nil
end

M.next = function() if any_listed() then vim.cmd('bnext') end end
M.previous = function() if any_listed() then vim.cmd('bprev') end end
M.first = function() if any_listed() then vim.cmd('bfirst') end end
M.last = function() if any_listed() then vim.cmd('blast') end end
M.delete = function() vim.cmd('bdelete') end
M.really_delete = function() vim.cmd('bdelete!') end
M.new = function() vim.cmd('enew') end

return M

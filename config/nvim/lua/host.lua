--
-- Loads optional plugins from our config package that contain
-- host and platform specific support
--

local cmd = vim.cmd
local fn = vim.fn

local function setup()
    if fn.exists('g:vscode') == 1 then
        cmd('packadd host-vscode')
    else
        cmd('packadd host-nvim')
    end
end

return { setup = setup }

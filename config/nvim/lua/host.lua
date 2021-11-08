--
-- Loads optional plugins from our config package that contain
-- platform specific support
--

local cmd = vim.cmd
local fn = vim.fn

local function setup()
    if fn.has('unix') == 1 then
        cmd('packadd platform-unix')
    end

    if fn.exists('g:vscode') == 1 then
        cmd('packadd host-vscode')
    else
        cmd('packadd host-nvim')
    end
end

return { setup = setup }

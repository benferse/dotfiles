-- Remote control and instance management of an already
-- running nvim server
local augroup = require('utils').augroup

local function setup()
    -- Make sure that internal terminals can launch this server
    -- as an editor
    vim.fn.setenv("GIT_EDITOR", [[nvr -cc split --remote-wait]])

    -- Delete temporary git message buffers as soon as possible
    -- so git stops waiting for us
    augroup('benferse#git_autoclose', {
        [[FileType gitcommit,gitrebase,gitconfig set bufhidden=delete]]
    })
end

return { setup = setup }

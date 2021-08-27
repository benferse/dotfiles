-- Navigation plugin configuration, keybind documentation,
-- and other bits for jumping about

local function setup(args)
    vim.cmd([[
        packadd which-key.nvim
    ]])

    local which_key = require('which-key')
    which_key.setup {
        window = {
            border = 'none',
            position = 'bottom',
        },
        triggers = 'auto',
        triggers_blacklist = {
            i = { 'j', 'k' },
            v = { 'j', 'k' },
        },
    }

    which_key.register  {
        ["<leader>b"] = {
            name = "Buffers",
            n = "Next",
            p = "Previous",
            d = "Hide",
            x = "Wipeout",
        },
    }
end

return { setup = setup }

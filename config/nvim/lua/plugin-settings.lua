--
-- Configuration for plugins that are always loaded regardless of how
-- and where we are running
--
local g = vim.g
local has = vim.fn.has
local map = require('utils').map

local silent = { silent = true }

local function setup()
    --
    -- Sneak configuration
    --
    g['sneak#s_next'] = 1
    g['sneak#use_ic_scs'] = 1
    g['sneak#prompt'] = 'sneak> '

    --
    -- Vim better whitespace
    --
    g.better_whitespace_enabled = 1
    g.strip_whitelines_at_eof = 1
    g.show_spaces_that_precede_tabs = 1

    map('n', ']w', ':NextTrailingWhitespace<cr>')
    map('n', '[w', ':PrevTrailingWhitespace<cr>')
end

return { setup = setup }

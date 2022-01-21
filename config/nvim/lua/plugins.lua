--
-- Configuration for plugins that are always loaded regardless of how
-- and where we are running
--
local g = vim.g
local map = require('utils').map

local function setup()
    --
    -- Vim better whitespace
    --
    g.better_whitespace_enabled = 2
    g.strip_whitelines_at_eof = 1
    g.show_spaces_that_precede_tabs = 1

    map('n', ']w', ':NextTrailingWhitespace<cr>')
    map('n', '[w', ':PrevTrailingWhitespace<cr>')
end

return { setup = setup }

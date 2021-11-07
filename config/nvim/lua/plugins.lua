--
-- Configuration for plugins that are always loaded regardless of how
-- and where we are running
--
local g = vim.g
local map = require('utils').map

local function setup()
    --
    -- hop.nvim, like easymotion and sneak and friends all in one
    -- pretty lua bundle
    --
    require('hop').setup()
    map({'n', 'o'}, 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, })<cr>")
    map({'n', 'o'}, 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, })<cr>")

    map({'n', 'o'}, 's', "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, })<cr>")
    map({'n', 'o'}, 'S', "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, })<cr>")

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

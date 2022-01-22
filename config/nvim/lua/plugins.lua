--
-- Configuration for plugins that are always loaded regardless of how
-- and where we are running
--
local g = vim.g
local utils = require('utils')

local function setup()
    --
    -- Vim better whitespace
    --
    g.better_whitespace_enabled = 0
    g.strip_only_modified_lines = 1
    g.strip_whitelines_at_eof = 1
    g.strip_whitespace_confirm = 0
    g.show_spaces_that_precede_tabs = 1

    utils.map('n', ']w', ':NextTrailingWhitespace<cr>')
    utils.map('n', '[w', ':PrevTrailingWhitespace<cr>')

    utils.augroup('benferse#trailing_whitespace', {
        [[FileType c,cpp,json,lua,rust,toml EnableWhitespace]],
        [[FileType c,cpp,json,lua,rust,toml EnableStripWhitespaceOnSave]]
    })
end

return { setup = setup }

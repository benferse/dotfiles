--
-- Standard keymaps that don't directly depend on any third-party plugins
--

local map = require('utils').map

local function setup()
    --
    -- Keeps calls to map() a little more terse :) Note that <cmd> mappings
    -- do not switch modes, so there's no need for <silent>
    --
    local silent = { silent = true }

    --
    -- Escape back to normal mode without having to stretch
    --
    map('i', 'jj', '<esc>')
    map('i', 'jk', '<esc>')
    map('i', 'kj', '<esc>')

    --
    -- This is honestly life changing
    --
    map('n', ';', '<cmd>up<cr>')

    --
    -- Use alt-L to clear the highlighting of hlsearch
    -- Courtesy of the inimitable tpope, modified for tmux
    --
    map('n', '<A-l>', [[:<C-u>nohlsearch<Bar><C-R>=has('diff')?'diffupdate':'mode'<cr><cr>]], silent)

    --
    -- Window management. Having to hit ctrl-w makes me sad sometimes
    --
    map('n', '<leader>w', '<C-w>')

    --
    -- Use ctrl+[h,j,k,l] to move between windows regardless of current mode.
    --
    map('n', '<C-h>', [[<cmd>call host#windows#left()<cr>]])
    map('n', '<C-j>', [[<cmd>call host#windows#down()<cr>]])
    map('n', '<C-k>', [[<cmd>call host#windows#up()<cr>]])
    map('n', '<C-l>', [[<cmd>call host#windows#right()<cr>]])

    --
    -- Intentionally not using a <cmd> mapping here because we explicitly
    -- want the mode change
    --
    map({'i','t'}, '<C-h>', [[<C-\><C-n>:<C-u>call host#windows#left()<cr>]], silent)
    map({'i','t'}, '<C-j>', [[<C-\><C-n>:<C-u>call host#windows#down()<cr>]], silent)
    map({'i','t'}, '<C-k>', [[<C-\><C-n>:<C-u>call host#windows#up()<cr>]], silent)
    map({'i','t'}, '<C-l>', [[<C-\><C-n>:<C-u>call host#windows#right()<cr>]], silent)

    --
    -- Buffer navigation
    --
    map('n', '<leader>be', [[<cmd>call host#buffers#new()<cr>]])
    map('n', '<leader>bn', [[<cmd>call host#buffers#next()<cr>]])
    map('n', '<leader>bp', [[<cmd>call host#buffers#previous()<cr>]])
    map('n', '<leader>bd', [[<cmd>call host#buffers#delete()<cr>]])
    map('n', '<leader>bx', [[<cmd>call host#buffers#really_delete()<cr>]])

    --
    -- vim-unimpaired sets these, but we want them to go through our smarts instead
    -- for vscode support
    --
    map('n', ']b', [[<cmd>call host#buffers#next()<cr>]])
    map('n', '[b', [[<cmd>call host#buffers#previous()<cr>]])
    map('n', ']B', [[<cmd>call host#buffers#last()<cr>]])
    map('n', '[B', [[<cmd>call host#buffers#first()<cr>]])

    --
    -- Fuzzy finder integration
    --
    map('n', '<leader>fb', [[<cmd>call host#fuzzy#find_buffers()<cr>]])
    map('n', '<leader>ff', [[<cmd>call host#fuzzy#find_files()<cr>]])

    --
    -- Traditional find-in-files integration.
    --
    map('n', '<leader>sf', [[<cmd>call host#search#find_in_files()<cr>]])
    map('n', '<leader>s.', [[<cmd>call host#search#find_by_word()<cr>]])

    --
    -- Explorer/tree interaction
    --
    map('n', '<leader>e', [[<cmd>call host#explorer#toggle()<cr>]])

    --
    -- Toggle the help window
    --
    map('n', '<F1>', [[host#help#is_open() ? '<cmd>helpclose<cr>' : '<cmd>Telescope help_tags<cr>']], { silent = true, expr = true })

    --
    -- Recenter on incremental search results
    --
    map('n', 'n', 'nzz', silent)
    map('n', 'N', 'Nzz', silent)
    map('n', '*', '*zz', silent)
    map('n', '#', '#zz', silent)
    map('n', 'g*', 'g*zz', silent)
    map('n', 'g#', 'g#zz', silent)
end

return { setup = setup }

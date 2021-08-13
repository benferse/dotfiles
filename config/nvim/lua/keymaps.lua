--
-- Standard keymaps that don't directly depend on any third-party plugins
--
local map = require('utils').map

local function setup()
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
    map('n', ';', ':<C-u>up<cr>')

    --
    -- Use alt-L to clear the highlighting of hlsearch
    -- Courtesy of the inimitable tpope, modified for tmux
    --
    map('n', '<A-l>', [[:nohlsearch<Bar><C-R>=has('diff')?'diffupdate':'mode'<cr><cr>]], silent)

    --
    -- Window management. Having to hit ctrl-w makes me sad sometimes
    --
    map('n', '<leader>w', '<C-w>')

    --
    -- Use ctrl+[h,j,k,l] to move between windows regardless of current mode.
    --
    map('n', '<C-h>', [[:<C-u>call host#windows#left()<cr>]], silent)
    map('n', '<C-j>', [[:<C-u>call host#windows#down()<cr>]])
    map('n', '<C-k>', [[:<C-u>call host#windows#up()<cr>]], silent)
    map('n', '<C-l>', [[:<C-u>call host#windows#right()<cr>]], silent)

    map({'i','t'}, '<C-h>', [[<C-\><C-n>:<C-u>call host#windows#left()<cr>]], silent)
    map({'i','t'}, '<C-j>', [[<C-\><C-n>:<C-u>call host#windows#down()<cr>]], silent)
    map({'i','t'}, '<C-k>', [[<C-\><C-n>:<C-u>call host#windows#up()<cr>]], silent)
    map({'i','t'}, '<C-l>', [[<C-\><C-n>:<C-u>call host#windows#right()<cr>]], silent)

    --
    -- Buffer navigation
    --
    map('n', '<leader>bn', [[:<C-u>call host#buffers#next()<cr>]], silent)
    map('n', '<leader>bp', [[:<C-u>call host#buffers#previous()<cr>]], silent)
    map('n', '<leader>bd', [[:<C-u>call host#buffers#delete()<cr>]], silent)
    map('n', '<leader>bx', [[:<C-u>call host#buffers#really_delete()<cr>]], silent)

    --
    -- vim-unimpaired sets these, but we want them to go through our smarts instead
    -- for vscode support
    --
    map('n', ']b', [[:<C-u>call host#buffers#next()<cr>]], silent)
    map('n', '[b', [[:<C-u>call host#buffers#previous()<cr>]], silent)
    map('n', ']B', [[:<C-u>call host#buffers#last()<cr>]], silent)
    map('n', '[B', [[:<C-u>call host#buffers#first()<cr>]], silent)

    --
    -- Fuzzy finder integration
    --
    map('n', '<leader>bb', [[:<C-u>call host#fuzzy#find_buffers()<cr>]], silent)
    map('n', '<leader>ff', [[:<C-u>call host#fuzzy#find_files()<cr>]], silent)

    --
    -- Traditional find-in-files integration
    --
    map('n', '<leader>gg', [[:<C-u>call host#search#find_in_files()<cr>]], silent)
    map('n', '<leader>g.', [[:<C-u>call host#search#find_by_word("<C-r><C-w>")<cr>]], silent)

    --
    -- Explorer/tree interaction
    --
    map('n', '<leader>e', [[:<C-u>call host#explorer#toggle()<cr>]], silent)

    --
    -- Toggle the help window
    --
    map('n', '<leader>h', [[host#help#is_open() ? ':helpclose<cr>' : ':help ']], { silent = true, expr = true })

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

return {setup = setup}

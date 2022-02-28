-- Setup mapx here so that it's available with our chosen
-- options before the rest of the scripts in `plugin` run.
local is_ok, m = pcall(require, 'mapx')
if not is_ok then
    return
end

m.setup { global = true, whichkey = true }

-- Escape back to normal mode without having to stretch
m.imap({'jj', 'jk', 'kj'}, '<esc>')

-- This is honestly life changing, can't believe I lived
-- for over forty years without this
m.nnoremap(';', [[<cmd>up<cr>]])

---- Use alt-L to clear the highlighting of hlsearch
---- Courtesy of the inimitable tpope, modified for tmux
m.nnoremap('<A-l>', [[:<C-u>nohlsearch<Bar><C-R>=has('diff')?'diffupdate':'mode'<cr><cr>]])

----
---- Window management. Having to hit ctrl-w makes me sad sometimes
----
--map('n', '<leader>w', '<C-w>')
--
----
---- Jump directly to a visible window by its window ID
----
--for i=1,9 do
--    map('n', '<leader>'..i, i..'<C-w>w', 'which_key_ignore')
--end
--
----
---- Use ctrl+[h,j,k,l] to move between windows regardless of current mode.
----
--map('n', '<C-h>', [[<cmd>call host#windows#left()<cr>]])
--map('n', '<C-j>', [[<cmd>call host#windows#down()<cr>]])
--map('n', '<C-k>', [[<cmd>call host#windows#up()<cr>]])
--map('n', '<C-l>', [[<cmd>call host#windows#right()<cr>]])
--
----
---- Intentionally not using a <cmd> mapping here because we explicitly
---- want the mode change
----
--map({'i', 't'}, '<C-h>', [[<C-\><C-n>:<C-u>call host#windows#left()<cr>]])
--map({'i', 't'}, '<C-j>', [[<C-\><C-n>:<C-u>call host#windows#down()<cr>]])
--map({'i', 't'}, '<C-k>', [[<C-\><C-n>:<C-u>call host#windows#up()<cr>]])
--map({'i', 't'}, '<C-l>', [[<C-\><C-n>:<C-u>call host#windows#right()<cr>]])
--
----
---- Buffer navigation
----
--map('n', '<leader>be', [[<cmd>call host#buffers#new()<cr>]], [[New empty]])
--map('n', '<leader>bn', [[<cmd>call host#buffers#next()<cr>]], [[Next]])
--map('n', '<leader>bp', [[<cmd>call host#buffers#previous()<cr>]], [[Previous]])
--map('n', '<leader>bd', [[<cmd>call host#buffers#delete()<cr>]], [[Delete]])
--map('n', '<leader>bx', [[<cmd>call host#buffers#really_delete()<cr>]], [[Wipeout]])
--
----
---- vim-unimpaired sets these, but we want them to go through our smarts instead
---- for vscode support
----
--map('n', ']b', [[<cmd>call host#buffers#next()<cr>]])
--map('n', '[b', [[<cmd>call host#buffers#previous()<cr>]])
--map('n', ']B', [[<cmd>call host#buffers#last()<cr>]])
--map('n', '[B', [[<cmd>call host#buffers#first()<cr>]])
--
----
---- Fuzzy finder integration
----
--map('n', '<leader>fb', [[<cmd>call host#fuzzy#find_buffers()<cr>]], [[Buffers]])
--map('n', '<leader>ff', [[<cmd>call host#fuzzy#find_files()<cr>]], [[Files]])
--
----
---- Traditional find-in-files integration.
----
--map('n', '<leader>sf', [[<cmd>call host#search#find_in_files()<cr>]], [[In files]])
--map('n', '<leader>s.', [[<cmd>call host#search#find_by_word()<cr>]], [[Current word]])
--
----
---- Explorer/tree interaction
----
--map('n', '<leader>e', [[<cmd>call host#explorer#toggle()<cr>]], [[Explorer]])
--
----
---- Toggle the help window
----
--map('n', '<F1>', [[host#help#is_open() ? '<cmd>helpclose<cr>' : '<cmd>Telescope help_tags<cr>']], { expr = true })
--
----
---- Recenter on incremental search results
----
--map('n', 'n', 'nzz')
--map('n', 'N', 'Nzz')
--map('n', '*', '*zz')
--map('n', '#', '#zz')
--map('n', 'g*', 'g*zz', "Next non-word match")
--map('n', 'g#', 'g#zz', "Previous non-word match")

-- Setup mapx here so that it's available with our chosen
-- options before the rest of the scripts in `plugin` run.
local is_ok, m = pcall(require, 'mapx')
if not is_ok then
    return
end

m.setup { global = true, whichkey = true }

-- Escape back to normal mode without having to stretch
m.imap({'jj', 'jk', 'kj'}, '<esc>')

m.nnoremap('j', [[v:count ? 'j' : 'gj']], 'expr')
m.nnoremap('k', [[v:count ? 'k' : 'gk']], 'expr')

-- This is honestly life changing, can't believe I lived
-- for over forty years without this
m.nnoremap(';', [[<cmd>up<cr>]])

---- Use alt-L to clear the highlighting of hlsearch
---- Courtesy of the inimitable tpope, modified for tmux
m.nnoremap('<A-l>', [[:<C-u>nohlsearch<Bar><C-R>=has('diff')?'diffupdate':'mode'<cr><cr>]])

local host = require('host')

m.nname(    '<leader>b',              'Buffers')
m.nnoremap( '<leader>be',             host.buffers.new,           [[New empty buffer]])
m.nnoremap({'<leader>bn', 'L', ']b'}, host.buffers.next,          [[Next buffer]])
m.nnoremap({'<leader>bp', 'H', '[b'}, host.buffers.previous,      [[Previous buffer]])
m.nnoremap( '<leader>bd',             host.buffers.delete,        [[Delete buffer]])
m.nnoremap( '<leader>bx',             host.buffers.really_delete, [[Wipeout buffer]])

--
-- Fuzzy finder integration
--
m.nname(   '<leader>f',  'Fuzzy')
m.nnoremap('<leader>fb', host.fuzzy.buffers, [[Find buffer]])
m.nnoremap('<leader>ff', host.fuzzy.files,   [[Find files]])

--
-- Traditional find-in-files integration.
--
m.nname('<leader>s', 'Search')
m.nnoremap('<leader>sf', host.search.in_files, [[In files]])
m.nnoremap('<leader>s.', host.search.by_word,  [[Current word]])

--
-- Window management. Having to hit ctrl-w makes me sad sometimes
-- (okay, most of the time)
--
m.nname('<leader>w', 'Windows')
m.nnoremap({'<leader>wh', '<C-h>'}, host.windows.left,  [[Move cursor left]])
m.nnoremap({'<leader>wj', '<C-j>'}, host.windows.down,  [[Move cursor down]])
m.nnoremap({'<leader>wk', '<C-k>'}, host.windows.up,    [[Move cursor up]])
m.nnoremap({'<leader>wl', '<C-l>'}, host.windows.right, [[Move cursor right]])

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
---- vim-unimpaired sets these, but we want them to go through our smarts instead
---- for vscode support
----
--map('n', ']b', [[<cmd>call host#buffers#next()<cr>]])
--map('n', '[b', [[<cmd>call host#buffers#previous()<cr>]])
--map('n', ']B', [[<cmd>call host#buffers#last()<cr>]])
--map('n', '[B', [[<cmd>call host#buffers#first()<cr>]])
--
--
--
----
---- Explorer/tree interaction
----
--map('n', '<leader>e', [[<cmd>call host#explorer#toggle()<cr>]], [[Explorer]])
--
----
---- Toggle the help window
----
m.nmap('<F1>', host.help.toggle)
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

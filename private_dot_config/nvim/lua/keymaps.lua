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
m.nnoremap({'<leader>bf',      '[B'}, host.buffers.first,         [[First buffer]])
m.nnoremap({'<leader>bl',      ']B'}, host.buffers.last,          [[Last buffer]])
m.nnoremap({'<leader>bn', 'L', ']b'}, host.buffers.next,          [[Next buffer]])
m.nnoremap({'<leader>bp', 'H', '[b'}, host.buffers.previous,      [[Previous buffer]])
m.nnoremap( '<leader>bd',             host.buffers.delete,        [[Delete buffer]])
m.nnoremap( '<leader>bx',             host.buffers.really_delete, [[Wipeout buffer]])

-- Fuzzy finder integration
m.nname(   '<leader>f',  'Fuzzy')
m.nnoremap('<leader>fb', host.fuzzy.buffers, [[Find buffer]])
m.nnoremap('<leader>ff', host.fuzzy.files,   [[Find files]])

-- LSP integration. The lsp module will also add several per-buffer
-- mappings for individual LSP server capabilities, but the ones here
-- should be generic enough to be global
m.nname('<leader>l', 'LSP')
m.nnoremap('<leader>ll', '<cmd>lua vim.diagnostic.setloclist()<cr>', 'Loclist diagnostics')
m.nnoremap('<leader>lq', '<cmd>lua vim.diagnostic.setqflist()<cr>',  'Quickfix diagnostics')
m.nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<cr>')

-- Traditional find-in-files integration.
m.nname('<leader>s', 'Search')
m.nnoremap('<leader>sf', host.search.in_files, [[In files]])
m.nnoremap('<leader>s.', host.search.by_word,  [[Current word]])

-- What other IDEs might call views / panels / etc.
m.name(    '<leader>v', 'View')
m.nnoremap('<leader>ve', host.views.explorer, [[File explorer]])
m.nnoremap('<leader>vg', host.views.git,      [[Git]])
m.nnoremap('<leader>vp', host.views.profiler, [[System info]])

-- Window management. Having to hit ctrl-w makes me sad sometimes
-- (okay, most of the time)
m.nname('<leader>w', 'Windows')
m.nnoremap({'<leader>wh', '<C-h>'}, host.windows.left,  [[Move cursor left]])
m.nnoremap({'<leader>wj', '<C-j>'}, host.windows.down,  [[Move cursor down]])
m.nnoremap({'<leader>wk', '<C-k>'}, host.windows.up,    [[Move cursor up]])
m.nnoremap({'<leader>wl', '<C-l>'}, host.windows.right, [[Move cursor right]])

-- Jump to a window by its ID (which is always in the status line <3)
for i=1,9 do
    m.nnoremap('<leader>'..i, i..'<C-w>w', 'Goto window '..i)
end

-- Intentionally not using a <cmd> mapping here because we explicitly
-- want the mode change
m.inoremap('<C-h>', [[<C-\><C-n>:<C-u>lua require('host').windows.left()<cr>]])
m.inoremap('<C-j>', [[<C-\><C-n>:<C-u>lua require('host').windows.down()<cr>]])
m.inoremap('<C-k>', [[<C-\><C-n>:<C-u>lua require('host').windows.up()<cr>]])
m.inoremap('<C-l>', [[<C-\><C-n>:<C-u>lua require('host').windows.right()<cr>]])
m.tnoremap('<C-h>', [[<C-\><C-n>:<C-u>lua require('host').windows.left()<cr>]])
m.tnoremap('<C-j>', [[<C-\><C-n>:<C-u>lua require('host').windows.down()<cr>]])
m.tnoremap('<C-k>', [[<C-\><C-n>:<C-u>lua require('host').windows.up()<cr>]])
m.tnoremap('<C-l>', [[<C-\><C-n>:<C-u>lua require('host').windows.right()<cr>]])

-- Toggle the help window. If it's not open, we get a finder.
-- If it is, then we close it.
m.nmap('<F1>', host.help.toggle)

-- Recenter on incremental search results
m.nnoremap('n', 'nzz')
m.nnoremap('N', 'Nzz')
m.nnoremap('*', '*zz')
m.nnoremap('#', '#zz')
m.nnoremap('g*', 'g*zz', "Next non-word match")
m.nnoremap('g#', 'g#zz', "Previous non-word match")

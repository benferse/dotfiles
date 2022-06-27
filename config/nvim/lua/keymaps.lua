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
m.nnoremap('<A-l>', [[:<C-u>nohlsearch<Bar>mes clear<Bar><C-R>=has('diff')?'diffupdate':'mode'<cr><cr>]], { silent = true })

local host = require('host')

-- Buffer navigation and management
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
m.nnoremap('<leader>fb', host.fuzzy.buffers,  [[Find buffer]])
m.nnoremap('<leader>ff', host.fuzzy.files,    [[Find files]])
m.nnoremap('<leader>fp', host.fuzzy.projects, [[Find projects]])
m.nnoremap('<leader>fr', host.fuzzy.recent,   [[Find recent files]])

-- Git
m.nname(   '<leader>g', 'Git')
m.nnoremap('<leader>gc', '<cmd>Telescope git_commits<cr>',  'Browse commits')
m.nnoremap('<leader>go', '<cmd>Telescope git_status<cr>',   'Browse pending')

m.nnoremap('<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', 'Reset hunk')
m.vnoremap('<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', 'Reset hunk')
m.nnoremap('<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', 'Stage hunk')
m.vnoremap('<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', 'Stage hunk')

m.nnoremap('<leader>gR', '<cmd>Gitsigns reset_buffer<cr>', 'Reset buffer')
m.nnoremap('<leader>gS', '<cmd>Gitsigns stage_buffer<cr>', 'Stage buffer')

m.nnoremap('<leader>gu', '<cmd>Gitsigns undo_stage_hunk<cr>',    'Unstage hunk')
m.nnoremap('<leader>gU', '<cmd>Gitsigns reset_buffer_index<cr>', 'Reset buffer from index')

m.nnoremap('<leader>gp', '<cmd>Gitsigns preview_hunk<cr>', 'Preview hunk')
m.nnoremap('<leader>gb', '<cmd>lua require("gitsigns").blame_line{full=true}<cr>', 'Blame line')

m.nnoremap(']c', [[&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>']], { expr = true, label = 'Next hunk' })
m.nnoremap('[c', [[&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>']], { expr = true, label = 'Previous hunk' })

m.onoremap('ih', ':<C-U>Gitsigns select_hunk<cr>', 'Hunk')
m.xnoremap('ih', ':<C-U>Gitsigns select_hunk<cr>', 'Hunk')

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
m.nnoremap('<leader>vb', host.views.debugger, [[Debugging]])
m.nnoremap('<leader>ve', host.views.explorer, [[File explorer]])
m.nnoremap('<leader>vg', host.views.git,      [[Git]])
m.nnoremap('<leader>vp', host.views.profiler, [[System info]])
m.nnoremap('<leader>vm', host.views.markdown, [[Markdown preview]])
m.nnoremap('<leader>vs', host.views.symbols,  [[Symbol outline]])

-- Window management. Having to hit ctrl-w makes me sad sometimes
-- (okay, most of the time)
m.nname('<leader>w', 'Windows')
m.nnoremap({'<leader>wh', '<C-h>'}, host.windows.left,  [[Move cursor left]])
m.nnoremap({'<leader>wj', '<C-j>'}, host.windows.down,  [[Move cursor down]])
m.nnoremap({'<leader>wk', '<C-k>'}, host.windows.up,    [[Move cursor up]])
m.nnoremap({'<leader>wl', '<C-l>'}, host.windows.right, [[Move cursor right]])

m.nnoremap('<leader>wc', host.windows.close, [[Close this window]])
m.nnoremap('<leader>wo', host.windows.only,  [[Close other windows]])

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

-- Combined quickfix/location/trouble list and navigation
m.nname('<leader>x', 'Trouble')
m.nnoremap('<leader>xx', [[<cmd>TroubleToggle<cr>]],                       [[Toggle open/close]])
m.nnoremap('<leader>xd', [[<cmd>TroubleToggle document_diagnostics<cr>]],  [[Document diagnostics]])
m.nnoremap('<leader>xl', [[<cmd>TroubleToggle loclist<cr>]],               [[Location list]])
m.nnoremap('<leader>xq', [[<cmd>TroubleToggle quickfix<cr>]],              [[Quickfix list]])
m.nnoremap('<leader>xr', [[<cmd>TroubleToggle lsp_references<cr>]],        [[LSP references]])
m.nnoremap('<leader>xt', [[<cmd>TodoTrouble<cr>]],                         [[To-dos]])
m.nnoremap('<leader>xw', [[<cmd>TroubleToggle workspace_diagnostics<cr>]], [[Workspace diagnostics]])

m.nnoremap(']x', [[<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>]], [[Next trouble]])
m.nnoremap('[x', [[<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>]], [[Previous trouble]])

m.nnoremap(']q', [[<cmd>cnext<cr>]], [[Next quickfix]])
m.nnoremap('[q', [[<cmd>cprev<cr>]], [[Previous quickfix]])
m.nnoremap(']Q', [[<cmd>clast<cr>]], [[Last quickfix]])
m.nnoremap('[Q', [[<cmd>cfirst<cr>]], [[First quickfix]])

m.nnoremap(']l', [[<cmd>lnext<cr>]], [[Next location]])
m.nnoremap('[l', [[<cmd>lprev<cr>]], [[Previous location]])
m.noremap(']L', [[<cmd>llast<cr>]], [[Last location]])
m.nnoremap('[L', [[<cmd>lfirst<cr>]], [[First location]])

-- Symbol navigation
m.nnoremap(']a', [[<cmd>AerialNext<cr>]], [[Next symbol]])
m.nnoremap('[a', [[<cmd>AerialPrev<cr>]], [[Previous symbol]])

-- Goto
m.nnoremap('ge', 'G', [[Goto the end of the file]])
m.nnoremap('gh', '0', [[Goto the beginning of the line]])
m.nnoremap('gl', '$', [[Goto the end of the line]])
m.nnoremap('gs', '^', [[Goto the start of the line]])
m.nnoremap('gt', 'H', [[Goto the top of the screen]])
m.nnoremap('gm', 'M', [[Goto the middle of the screen]])
m.nnoremap('gb', 'L', [[Goto the bottom of the screen]])
m.nnoremap('gn', host.buffers.next, [[Goto the next buffer]])
m.nnoremap('gp', host.buffers.previous, [[Goto the previous buffer]])
m.nnoremap('g.', '`.', [[Goto last modified location]])

-- Mark/surround/sandwich
m.nnoremap('ma', [[<Plug>SurroundAddNormal]], "Add surrounding...")
m.nnoremap('md', [[<Plug>SurroundDelete]], "Delete surrounding...")
m.nnoremap('mr', [[<Plug>SurroundReplace]], "Replace surrounding...")
m.xnoremap('m',  [[<Plug>SurroundAddVisual]], "Surround selection")

-- Toggle the help window. If it's not open, we get a finder.
-- If it is, then we close it.
m.nmap('<F1>', host.help.toggle)

-- Debugging
m.nnoremap('<F5>',    [[<cmd>lua require('dap').continue()<cr>]])
m.nnoremap('<F9>',    [[<cmd>lua require('dap').toggle_breakpoint()<cr>]])
m.nnoremap('<S-F9>',  [[<cmd>lua require('dap').set_breakpoint(vim.fn.input("Condition: "))<cr>]])
m.nnoremap('<F10>',   [[<cmd>lua require('dap').step_over()<cr>]])
m.nnoremap('<F11>',   [[<cmd>lua require('dap').step_into()<cr>]])
m.nnoremap('<S-F11>', [[<cmd>lua require('dap').step_out()<cr>]])

-- Recenter on incremental search results
m.nnoremap('n', 'nzz')
m.nnoremap('N', 'Nzz')
m.nnoremap('*', '*zz')
m.nnoremap('#', '#zz')
m.nnoremap('g*', 'g*zz', "Next non-word match")
m.nnoremap('g#', 'g#zz', "Previous non-word match")

m.nnoremap([[']], [[`]])

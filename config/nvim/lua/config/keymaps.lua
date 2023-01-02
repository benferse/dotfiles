local wk = require("which-key")
local host = require("host")

wk.setup({
    show_help = false,
    triggers = "auto",
    plugins = { spelling = true },
    key_labels = { ["<leader>"] = "SPC" },
})

local keymaps = {
    ["<leader>"] = {
        b = {
            name = "+Buffers",
            d = { host.buffers.delete, [[Delete buffer]] },
            e = { host.buffers.new, [[New empty buffer]] },
            f = { host.buffers.first, [[First buffer]] },
            l = { host.buffers.last, [[Last buffer]] },
            n = { host.buffers.next, [[Next buffer]] },
            p = { host.buffers.previous, [[Previous buffer]] },
            x = { host.buffers.really_delete, [[Wipeout buffer]] },
        },
        f = {
            name = "+Fuzzy",
            b = { host.fuzzy.buffers, [[Find buffer]] },
            f = { host.fuzzy.files, [[Find files]] },
            r = { host.fuzzy.recent, [[Find recent files]] },
        },
        g = {
            name = "+Git",
            c = { "<cmd>Telescope git_commits<cr>", [[Browse commits]] },
            o = { "<cmd>Telescope git_status<cr>", [[Browse pending]] },
            r = { "<cmd>Gitsigns reset_hunk<cr>", [[Reset hunk]] },
            s = { "<cmd>Gitsigns stage_hunk<cr>", [[Stage hunk]] },
            R = { "<cmd>Gitsigns reset_buffer<cr>", [[Reset buffer]] },
            S = { "<cmd>Gitsigns stage_buffer<cr>", [[Stage buffer]] },
            u = { "<cmd>Gitsigns undo_stage_hunk<cr>", [[Unstage hunk]] },
            U = { "<cmd>Gitsigns reset_buffer_index<cr>", [[Reset buffer from index]] },
            p = { "<cmd>Gitsigns preview_hunk<cr>", [[Preview hunk]] },
            b = { [[<cmd>lua require("gitsigns").blame_line{full=true}<cr>]], [[Blame line]] },
        },
        l = {
            name = "+LSP",
            l = { vim.diagnostic.setloclist, [[Loclist diagnostics]] },
            q = { vim.diagnostic.setpflist, [[Quickfix diagnostics]] },
        },
        s = {
            name = "+Search",
            f = { host.search.in_files, [[In files]] },
            ["."] = { host.search.by_word, [[Current word]] },
        },
        v = {
            name = "+View",
            b = { host.views.debugger, [[Debugging]] },
            e = { host.views.explorer, [[File explorer]] },
            g = { host.views.git, [[Git]] },
            p = { host.views.profiler, [[System info]] },
            s = { host.views.symbols, [[Symbol outline]] },
        },
        w = {
            name = "+Windows",
            h = { host.windows.left,  [[Move cursor left]] },
            j = { host.windows.down,  [[Move cursor down]] },
            k = { host.windows.up,    [[Move cursor up]] },
            l = { host.windows.right, [[Move cursor right]] },

            c = { host.windows.close, [[Close this window]] },
            o = { host.windows.only,  [[Close other window]] },

            ["1"] = { "1<C-w>w", [[Goto window 1]] },
            ["2"] = { "2<C-w>w", [[Goto window 2]] },
            ["3"] = { "3<C-w>w", [[Goto window 3]] },
            ["4"] = { "4<C-w>w", [[Goto window 4]] },
            ["5"] = { "5<C-w>w", [[Goto window 5]] },
            ["6"] = { "6<C-w>w", [[Goto window 6]] },
            ["7"] = { "7<C-w>w", [[Goto window 7]] },
            ["8"] = { "8<C-w>w", [[Goto window 8]] },
            ["9"] = { "9<C-w>w", [[Goto window 9]] },
        },
    },
    ["["] = {
        name = "+Previous",
        b = { host.buffers.previous, [[Previous buffer]] },
        B = { host.buffers.first, [[First buffer]] },
        h = [[Previous hunk]],
        x = { function() require("trouble").previous({skip_groups = true, jump = true}) end, [[Previous trouble]] },
        X = { function() require("trouble").first({skip_groups = true, jump = true}) end, [[First trouble]] },
        q = { [[<cmd>cprev<cr>]], [[Previous quickfix]] },
        Q = { [[<cmd>cfirst<cr>]], [[First quickfix]] },
        l = { [[<cmd>lprev<cr>]], [[Previous location]] },
        L = { [[<cmd>lfirst<cr>]], [[First location]] },
    },
    ["]"] = {
        name = "+Next",
        b = { host.buffers.next, [[Next buffer]] },
        B = { host.buffers.last, [[Last buffer]] },
        h = [[Next hunk]],
        x = { function() require("trouble").next({skip_groups = true, jump = true}) end, [[Next trouble]] },
        X = { function() require("trouble").last({skip_groups = true, jump = true}) end, [[Last trouble]] },
        q = { [[<cmd>cnext<cr>]], [[Next quickfix]] },
        Q = { [[<cmd>clast<cr>]], [[Last quickfix]] },
        l = { [[<cmd>lnext<cr>]], [[Next location]] },
        L = { [[<cmd>llast<cr>]], [[Last location]] },
    },
}

wk.register(keymaps)

vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("i", "kj", "<esc>")

vim.keymap.set("n", "<C-h>", host.windows.left)
vim.keymap.set("n", "<C-j>", host.windows.down)
vim.keymap.set("n", "<C-k>", host.windows.up)
vim.keymap.set("n", "<C-l>", host.windows.right)

-- Intentionally not using <cmd> mappings for these because we want the mode switch
vim.keymap.set({"i", "t"}, "<C-h>", [[<C-\><C-n>:<C-u>lua require("host").windows.left()<cr>]])
vim.keymap.set({"i", "t"}, "<C-j>", [[<C-\><C-n>:<C-u>lua require("host").windows.down()<cr>]])
vim.keymap.set({"i", "t"}, "<C-k>", [[<C-\><C-n>:<C-u>lua require("host").windows.up()<cr>]])
vim.keymap.set({"i", "t"}, "<C-l>", [[<C-\><l-n>:<C-u>lua require("host").windows.right()<cr>]])

vim.keymap.set("n", ";", [[<cmd>up<cr>]])

vim.keymap.set("n", "<F1>", host.help.toggle)

vim.keymap.set("n", "H", host.buffers.previous)
vim.keymap.set("n", "L", host.buffers.next)

---- Use alt-L to clear the highlighting of hlsearch
---- Courtesy of the inimitable tpope, modified for tmux
vim.keymap.set("n", '<A-l>', [[:<C-u>nohlsearch<Bar>mes clear<Bar><C-R>=has('diff')?'diffupdate':'mode'<cr><cr>]], { silent = true })

-- Shamelessly stolen from folke
local id
for _, key in ipairs({ "h", "j", "k", "l" }) do
  local count = 0
  vim.keymap.set("n", key, function()
    if count >= 10 then
      id = vim.notify("Hold it Cowboy!", vim.log.levels.WARN, {
        icon = "🤠",
        replace = id,
        keep = function()
          return count >= 10
        end,
      })
    else
      count = count + 1
      vim.defer_fn(function()
        count = count - 1
      end, 5000)
      return key
    end
  end, { expr = true })
end

vim.keymap.set("n", "]h", [[&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>']], { expr = true })
vim.keymap.set("n", "[h", [[&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>']], { expr = true })

vim.keymap.set({"o", "x"}, "ih", [[:<C-u>Gitsigns select_hunk<cr>]])

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "g*", "g*zz")
vim.keymap.set("n", "g#", "g#zz")

vim.keymap.set("n", "'", "`")

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
        },
    },
    ["["] = {
        name = "+Previous",
        b = { host.buffers.previous, [[Previous buffer]] },
        B = { host.buffers.first, [[First buffer]] },
        x = { function() require("trouble").previous({skip_groups = true, jump = true}) end, [[Previous trouble]] },
        X = { function() require("trouble").first({skip_groups = true, jump = true}) end, [[First trouble]] },
    },
    ["]"] = {
        name = "+Next",
        b = { host.buffers.next, [[Next buffer]] },
        B = { host.buffers.last, [[Last buffer]] },
        x = { function() require("trouble").next({skip_groups = true, jump = true}) end, [[Next trouble]] },
        X = { function() require("trouble").last({skip_groups = true, jump = true}) end, [[Last trouble]] },
    },
}

wk.register(keymaps)

vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("i", "kj", "<esc>")

vim.keymap.set("n", ";", [[<cmd>up<cr>]])

vim.keymap.set("n", "<F1>", require("host").help.toggle)

vim.keymap.set("n", "H", host.buffers.previous)
vim.keymap.set("n", "L", host.buffers.next)

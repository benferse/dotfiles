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
            d = { function() require("host").buffers.delete() end, [[Delete buffer]] },
            e = { function() require("host").buffers.new() end, [[New empty buffer]] },
            f = { function() require("host").buffers.first() end, [[First buffer]] },
            l = { function() require("host").buffers.last() end, [[Last buffer]] },
            n = { function() require("host").buffers.next() end, [[Next buffer]] },
            p = { function() require("host").buffers.previous() end, [[Previous buffer]] },
            x = { function() require("host").buffers.really_delete() end, "Wipeout buffer" },
        },
        f = {
            name = "+Fuzzy",
            b = { function() require("host").fuzzy.buffers() end, [[Find buffer]] },
            f = { function() require("host").fuzzy.files() end, [[Find files]] },
            r = { function() require("host").fuzzy.recent() end, [[Find recent files]] },
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
}

wk.register(keymaps)

vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("i", "kj", "<esc>")

vim.keymap.set("n", ";", [[<cmd>up<cr>]])

vim.keymap.set("n", "<F1>", require("host").help.toggle)


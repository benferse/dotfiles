-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keymaps in this file are non plugin specific, and will use basic vim/nvim features or
-- our own functions. Well, built-in features. No promise on whether or not they're basic :)

-- Escape back to normal mode without having to stretch
vim.keymap.set("i", "kj", "<cmd>noh<cr><esc>")
vim.keymap.set("i", "jj", "<cmd>noh<cr><esc>")

-- Undo breakpoints for code editing. Insert logical places to "undo" to within a single
-- line
vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("i", ";", ";<C-g>u")

-- This is honestly life changing. I can't believe I lived
-- for over forty years without this
vim.keymap.set("n", ";", "<cmd>silent up<cr>")

-- While already in insert mode, move to the end of the next line and continue editing,
-- or open a new line and continue editing, both of which come up more often than you'd think
vim.keymap.set("i", "<M-CR>", "<C-O>2g_<C-O>A")
vim.keymap.set("i", "<S-CR>", "<cmd>normal! O<cr>")
vim.keymap.set("i", "<C-CR>", "<cmd>normal! o<cr>")

-- Move lines up or down
vim.keymap.set("n", "<M-j>", ":m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("n", "<M-k>", ":m .-2<cr>==", { desc = "Move down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move down" })

-- Mappings that start with [ or ] generally come in paris and involve next/prev or fwd/back
-- navigations that come in pairs, a-la vim-unimpaired
vim.keymap.set({ "n", "v" }, "]<Tab>", "gt", { desc = "Tab page" })
vim.keymap.set({ "n", "v" }, "[<Tab>", "gT", { desc = "Tab page" })

-- ]c and [c move between diff chunks in diffmode, while ]h and [h move between git hunks in
-- non-diff mode. Those are close enough operations; wouldn't it be nice if they were consistent?
-- I agree.
vim.keymap.set("n", "]h", [[&diff ? ']c' : ']h']], { expr = true, desc = "Difference", remap = true })
vim.keymap.set("n", "[h", [[&diff ? '[c' : '[h']], { expr = true, desc = "Difference", remap = true })

vim.keymap.set("n", "]Q", "<cmd>clast<cr>", { desc = "Last trouble/quickfix item" })
vim.keymap.set("n", "[Q", "<cmd>cfirst<cr>", { desc = "First trouble/quickfix item" })

vim.keymap.set("n", "[y", "<cmd>AerialPrev<cr>", { desc = "Symbol (Aerial)" })
vim.keymap.set("n", "]y", "<cmd>AerialNext<cr>", { desc = "Symbol (Aerial)" })

-- Custom textobjects for the entire document (mnemonic "an everything" :))
local function entire_buffer_textobj()
  local mode = vim.api.nvim_get_mode().mode
  local is_visual = string.lower(string.sub(mode, 1, 1)) == "v"

  vim.fn.execute("normal! m`")
  vim.fn.execute("keepjumps normal! gg0")
  vim.fn.execute("normal! " .. (is_visual and "o" or "V"))
  vim.fn.execute("keepjumps normal! G$")
end

vim.keymap.set({ "o", "x" }, "ae", entire_buffer_textobj, { desc = "Entire buffer" })

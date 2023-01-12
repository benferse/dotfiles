-- This file is loaded by the "configuration" plugin spec
--
-- Keymaps in this file are not plugin-specific, and will use basic vim/nvim features or
-- our own functions

-- Escape back to normal mode without having to stretch
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("i", "jj", "<esc>")

-- Always prefer display lines over text lines when moving up and down, unless
-- we're given a count of lines (which probably means you're navigating using
-- the number line
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Undo breakpoints for code editing. Insert logical places to "undo" to within a single
-- line
vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("i", ";", ";<C-g>u")

-- This is honestly life changing. I can't believe I lived
-- for over forty years without this
vim.keymap.set("n", ";", "<cmd>up<cr>")

-- Use n and N to consistently move forward and backward, regardless of whether you used / or
-- ? to initiate the search. See https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set({"n", "x", "o"}, "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set({"n", "x", "o"}, "N", "'nN'[v:searchforward]", { expr = true })

-- Don't lose the selection when shifting left or right.
-- See https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Resize the current window using Shift+Arrow keys
vim.keymap.set({"i", "n"}, "<S-Up>", "<cmd>resize +2<cr>")
vim.keymap.set({"i", "n"}, "<S-Down>", "<cmd>resize -2<cr>")
vim.keymap.set({"i", "n"}, "<S-Right>", "<cmd>vertical resize +2<cr>")
vim.keymap.set({"i", "n"}, "<S-Left>", "<cmd>vertical resize -2<cr>")

-- Navigate using CTRL-hjkl, pretty much regardless of mode. Note that insert and terminal
-- mode mappings intentionally do not use <cmd> because we want the mode change
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<cr>")

vim.keymap.set({"i", "t"}, "<C-h>", [[<C-\><C-n>:<C-u>wincmd h<cr>]])
vim.keymap.set({"i", "t"}, "<C-j>", [[<C-\><C-n>:<C-u>wincmd j<cr>]])
vim.keymap.set({"i", "t"}, "<C-k>", [[<C-\><C-n>:<C-u>wincmd k<cr>]])
vim.keymap.set({"i", "t"}, "<C-l>", [[<C-\><C-n>:<C-u>wincmd l<cr>]])

-- Leader-based mappings follow spacevim/etc. style conventions, where the first character
-- after <leader> is generally collection of related commands:
--
-- b - Buffers
-- g - Git
-- h - Help
-- q - Quit / Save / Restore sessions
-- w - Window navigation
-- x - Trouble / quickfix / location list
vim.keymap.set("n", "<leader>be", "<cmd>enew<cr>", { desc = "New" })

vim.keymap.set("n", "<leader>hq", "<cmd>helpclose<cr>", { desc = "Close help window" })

vim.keymap.set("n", "<leader>qX", "<cmd>qall<cr>", { desc = "Quit without saving" })
vim.keymap.set("n", "<leader>qW", "<cmd>xall<cr>", { desc = "Save all and quit" })

vim.keymap.set("n", "<leader>wh", "<cmd>wincmd h<cr>", { desc = "Go left" })
vim.keymap.set("n", "<leader>wj", "<cmd>wincmd j<cr>", { desc = "Go down" })
vim.keymap.set("n", "<leader>wk", "<cmd>wincmd k<cr>", { desc = "Go up" })
vim.keymap.set("n", "<leader>wl", "<cmd>wincmd l<cr>", { desc = "Go right" })

vim.keymap.set("n", "<leader>wc", "<C-w>c", { desc = "Close" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Only" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Quit" })

-- Mappings that start with [ and ] generally come in pairs and involve next/prev or fwd/back
-- navigations that come in pairs, a la vim-unimpaired, etc.

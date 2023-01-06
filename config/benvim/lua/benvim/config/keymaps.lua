-- This file is loaded by the "configuration" plugin spec

-- Escape back to normal mode without having to stretch
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("i", "jj", "<esc>")

-- Always prefer display lines over text lines when moving up and down
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- This is honestly life changing. I can't believe I lived
-- for over forty years without this
vim.keymap.set("n", ";", "<cmd>up<cr>")

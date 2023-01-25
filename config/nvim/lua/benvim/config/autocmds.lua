-- This file is loaded by the "configuration" plugin spec

-- Use hybrid numbering, but toggle between that and absolute
-- numbering on insert or leaving a window. I think this covers
-- all of the cases correctly...
vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave", "WinEnter"}, {
    pattern = "*",
    callback = function()
        if vim.o.number and vim.fn.mode() ~= "i" then
            vim.o.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter", "WinLeave"}, {
    pattern = "*",
    callback = function()
        if vim.o.number then
            vim.o.relativenumber = false
        end
    end,
})

-- When yanking/deleting text, highlight the affected text briefly
-- for a small visual cue
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- When opening a buffer, return to the last known location
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lines = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lines then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Check if a file needs to be reloaded due to an external change
vim.api.nvim_create_autocmd({"FocusGained", "TermClose", "TermLeave"}, {
    command = "checktime",
})

-- Close some transient / popup windows with `q` based on the filetype
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {
        "checkhealth",
        "help",
        "man",
        "notify",
        "qf",
        "lspinfo",
        "spectre_panel",
    },
    callback = function(event)
        -- Unlist the buffer, and add a silent mapping to close this window
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", [[<cmd>close<cr>]], { buffer = event.buf, silent = true })
    end,
})

-- A custom textobject that can identify a contiguous range of commented lines.
-- Treesitter can correctly identify multiline block comments as a single object,
-- but @comment.outer / @comment.inner will only recognize single lines sadly
local function commented_lines_textobject()
    local utils = require("Comment.utils")
    local current_line = vim.api.nvim_win_get_cursor(0)[1] -- current line
    local range = { srow = current_line, scol = 0, erow = current_line, ecol = 0 }
    local ctx = {
        ctype = utils.ctype.linewise,
        range = range,
    }
    local comment_string = require("Comment.ft").calculate(ctx) or vim.bo.commentstring
    local cs_left_marker, cs_right_marker = utils.unwrap_cstr(comment_string)
    local padding = true
    local is_commented = utils.is_commented(cs_left_marker, cs_right_marker, padding)

    local line = vim.api.nvim_buf_get_lines(0, current_line - 1, current_line, false)
    if next(line) == nil or not is_commented(line[1]) then
        return
    end

    local range_start, range_end = current_line, current_line
    repeat
        range_start = range_start - 1
        line = vim.api.nvim_buf_get_lines(0, range_start - 1, range_start, false)
    until next(line) == nil or not is_commented(line[1])
    range_start = range_start + 1
    repeat
        range_end = range_end + 1
        line = vim.api.nvim_buf_get_lines(0, range_end - 1, range_end, false)
    until next(line) == nil or not is_commented(line[1])
    range_end = range_end - 1

    vim.fn.execute("normal! " .. range_start .. "GV" .. range_end .. "G")
end

return {
    {
        -- Git integration in the editor
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "契" },
                topdelete = { text = "契" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
                end

                map("n", "]h", gs.next_hunk, "Git hunk")
                map("n", "[h", gs.prev_hunk, "Git hunk")

                map({ "n", "v" }, "<leader>gb", function() gs.blame_line { full = true, } end, "Blame line")
                map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")

                map({ "n", "v" }, "<leader>gs", function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage hunk")
                map({ "n", "v" }, "<leader>gr", function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Reset hunk")
                map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")

                map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
                map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")

                map("n", "<leader>tb", gs.toggle_current_line_blame, "git blame")
                map("n", "<leader>td", gs.toggle_deleted, "git deleted")

                map({ "o", "x" }, "ih", "<cmd>Gitsigns select_hunk<cr>", "Git hunk")
            end,
        },
    },
    -- Comments and autocommenting
    {
        "numToStr/Comment.nvim",
        event = "BufEnter",
        config = function()
            require("Comment").setup({
                padding = true,
                sticky = true,
                toggler = {
                    line = "gcc",
                    block = "gbc",
                },
                opleader = {
                    line = "gc",
                    block = "gb",
                },
                extra = {
                    above = "gcO",
                    below = "gco",
                    eol = "gcA",
                },
            })
        end,
        keys = {
            { "gc", commented_lines_textobject, silent = true, mode = "o", desc = "Commented lines" },
        },
    },
}

return {
    -- Git integration in the editor
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "契" },
            topdelete = { text = "契" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
        on_attach = function(bufnr)
            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
            end

            map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", "Git hunk")
            map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", "Git hunk")

            map({"n", "v"}, "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk")
            map({"n", "v"}, "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk")
            map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo stage hunk")

            map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", "Stage buffer")
            map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", "Stage buffer")

            map({"o", "x"}, "ih", "<cmd>Gitsigns select_hunk<cr>", "Git hunk")
        end,
    },
    -- Comments and autocommenting
    {
        "joosepalviste/nvim-ts-context-commentstring"
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        config = function()
            require("mini.comment").setup({
                hooks = {
                    pre = function()
                        require("ts_context_commentstring.internal").update_commentstring({})
                    end,
                },
            })
        end,
    },
}

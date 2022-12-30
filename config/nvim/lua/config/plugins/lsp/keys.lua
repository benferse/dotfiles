local wk = require("which-key")

local M = {}

function M.setup(client, bufnr)
    local keymap = {
        buffer = bufnr,
        ["<leader>"] = {
            c = {
                name = "+Code",
                a = {
                    { vim.lsp.buf.code_action, "Code Action" },
                    { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
                },
                d = {
                    { vim.diagnostic.open_float, "Line Diagnostics" },
                },
            },
        },
        ["g"] = {
            name = "+Goto",
            d = { "<cmd>Telescope lsp_definitions<cr>", "Definition" },
            r = { "<cmd>Telescope lsp_references<cr>", "References" },
        },
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
    }

    wk.register(keymap)
end

return M

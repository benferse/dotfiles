local wk = require("which-key")

local M = {}

function M.setup(client, bufnr)
    local keymap = {
        buffer = bufnr,

        ["<leader>"] = {
            l = {
                name = "+Code",
                a = {
                    { vim.lsp.buf.code_action, "Code Action" },
                    { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
                },
                d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
                f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format Document" },
                n = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Refactor: Rename" },
                r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto References" },
            },
        },
        ["g"] = {
            name = "+Goto",
            d = { "<cmd>Telescope lsp_definitions<cr>", "Definition" },
            r = { "<cmd>Telescope lsp_references<cr>", "References" },
            R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
        },
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
        ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous Diagnostic" },
        ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
    }

    wk.register(keymap)
end

return M

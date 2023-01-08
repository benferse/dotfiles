local function map(bufnr, mode, lhs, rhs, desc, opts)
    opts = opts or {}
    opts.silent = true
    opts.buffer = bufnr
    opts.desc = desc and "LSP: " .. desc or ""

    rhs = type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs

    vim.keymap.set(mode, lhs, rhs, opts)
end

local M = {}

-- Apply LSP-specific keymaps to buffers once the relevant LSP attaches to
-- them
function M.on_attach(client, bufnr)
    -- General mappings, available regardless of which capabilities the
    -- language server provides
    map(bufnr, "n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
    map(bufnr, "n", "<leader>cl", "LspInfo", "Provider info")

    map(bufnr, "n", "gd", "Telescope lsp_definitions", "Definition")
    map(bufnr, "n", "gr", "Telescope lsp_references", "References")

    map(bufnr, "n", "K", vim.lsp.buf.hover, "LSP: Hover/doc")

    map(bufnr, "n", "]d", vim.diagnostic.goto_next, "Diagnostic")
    map(bufnr, "n", "[d", vim.diagnostic.goto_prev, "Diagnostic")
    map(bufnr, "n", "]e", function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["ERROR"] })
    end, "Error")
    map(bufnr, "n", "[e", function()
        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["ERROR"] })
    end, "Error")
    map(bufnr, "n", "]w", function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["WARNING"] })
    end, "Warning")
    map(bufnr, "n", "[w", function()
        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["WARNING"] })
    end, "Warning")

    -- Capability-specific mappings
    local caps = client.server_capabilities

    if caps["signatureHelpProvider"] then
        map(bufnr, "n", "gK", vim.lsp.buf.signature_help, "Signature help")
    end

    if caps["codeActionProvider"] then
        map(bufnr, { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    end

    if caps["documentFormattingProvider"] then
        map(bufnr, "n", "<leader>cf", vim.lsp.buf.format, "Format document")
    end

    if caps["documentRangeFormattingProvider"] then
        map(bufnr, "v", "<leader>cf", vim.lsp.buf.format, "Format selection")
    end

    if caps["renameProvider"] then
        map(bufnr, "n", "<leader>cr", vim.lsp.buf.rename, "Rename")
    end

    -- If there is an LSP specific module, load it and let it do its thing as well
    local has_mod, mod = pcall(require, "benvim.features.lsp." .. client.name .. ".keymaps")
    if has_mod then
        mod.on_attach(client, bufnr)
    end
end

return M

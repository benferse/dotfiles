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
    map(bufnr, "n", "<leader>ld", vim.lsp.buf.definition, "Definition")
    map(bufnr, "n", "<leader>lr", vim.lsp.buf.references, "References")

    -- Replace the default `keywordprg` handling with LSP hover
    map(bufnr, "n", "K", vim.lsp.buf.hover, "Hover/doc")

    -- Capability-specific mappings. signature_help() raises an error if the
    -- server doesn't support the capability, so we only conditionally enable this
    -- mapping
    if client.server_capabilities["signatureHelpProvider"] then
        map(bufnr, "n", "gK", vim.lsp.buf.signature_help, "Signature help")
    end

    -- If there is an LSP specific module, load it and let it do its thing as well
    local has_mod, mod = pcall(require, "benvim.features.lsp." .. client.name .. ".keymaps")
    if has_mod then
        mod.on_attach(client, bufnr)
    end
end

return M

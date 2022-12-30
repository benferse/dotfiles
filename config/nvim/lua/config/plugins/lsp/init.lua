local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    pin = true,
}

function M.config()
    require("mason")
    require("config.plugins.lsp.diagnostics").setup()

    local function on_attach(client, bufnr)
        require("nvim-navic").attach(client, bufnr)
        require("config.plugins.lsp.keys").setup(client, bufnr)
    end

    local servers = {
        rust_analyzer = {
            settings = {
                ["rust-analyzer"] = {
                    cargo = { allFeatures = true },
                    checkOnSave = {
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                    },
                },
            },
        },
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    local options = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    }

    for server, opts in pairs(servers) do
        opts = vim.tbl_deep_extend("force", {}, options, opts or {})
        require("lspconfig")[server].setup(opts)
    end
end

return M

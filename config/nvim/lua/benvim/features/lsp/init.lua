return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "smiteshp/nvim-navic",
        },
        servers = {
            clangd = {},
            rust_analyzer = {},
            sumneko_lua = {
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            },
        },
        config = function(plugin)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require("benvim.features.lsp.keymaps").on_attach(client, bufnr)

                    if client.server_capabilities.documentSymbolProvider then
                        require("nvim-navic").attach(client, bufnr)
                    end
                end,
            })

            local default_caps =
            require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(plugin.servers) })
            require("mason-lspconfig").setup_handlers({
                function(server)
                    local opts = plugin.servers[server] or {}
                    opts.capabilities = default_caps
                    require("lspconfig")[server].setup(opts)
                end,
            })

            vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "", numhl = "" })
            vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "" })
            vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "" })
            vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "" })
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            local nls = require("null-ls")
            nls.setup({
                sources = {
                    nls.builtins.formatting.stylua,
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = {
            { "<leader>um", "<cmd>Mason<cr>", desc = "LSPs/Formatters (Mason)" },
        },
        config = function()
            require("mason").setup({})
            local reg = require("mason-registry")
            local ensure_installed = {
                "clangd",
                "lua-language-server",
                "rust-analyzer",
                "rustfmt",
                "shellcheck",
                "shfmt",
                "stylua",
            }
            for _, tool in ipairs(ensure_installed) do
                local p = reg.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        ft = "rust",
        opts = {
            tools = {
                inlay_hints = {
                    auto = true,
                },
            },
        },
    },
}

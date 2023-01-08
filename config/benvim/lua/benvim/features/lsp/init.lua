return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        servers = {
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
            { "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" } },
        },
        ensure_installed = {
            "lua-language-server",
            "rust-analyzer",
            "rustfmt",
            "shellcheck",
            "stylua",
        },
        config = function(plugin)
            require("mason").setup()
            local reg = require("mason-registry")
            for _, tool in ipairs(plugin.ensure_installed) do
                local p = reg.get_package(tool)
                if not p:is_installed() then
                    p.install()
                end
            end
        end,
    },
}

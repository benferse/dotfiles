return {
    {
        "neovim/nvim-lspconfig",
        branch = "master",
        event = "BufReadPre",
        dependencies = {
            "folke/neodev.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "smiteshp/nvim-navic",
        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    prefix = "●",
                },
                float = {
                    border = "rounded",
                },
                severity_sort = true,
            },
            servers = {
                clangd = {},
                rust_analyzer = require("benvim.features.lsp.rust_analyzer.settings"),
                lua_ls = require("benvim.features.lsp.lua_ls.settings"),
            },
        },
        config = function(_, opts)
            require("neodev").setup()

            -- Setup a hook to run when an LSP client attaches to a buffer.
            -- We'll do any LSP-specific setup then
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    -- Load any LSP-specific keymaps
                    require("benvim.features.lsp.keymaps").on_attach(client, bufnr)

                    -- Set LSP api options to connect standard vim features to LSP capabilities:
                    -- - connect formatting to the "formatexpr" expression
                    -- - connect omni completion to the LSP client's completion
                    -- - connect tag searching (e.g. CTRL-]) to the "textDocument/definition" or
                    --   "workspace/symbol" capabilities
                    --
                    -- These are all also exposed from LSP-specific workflows, but this way anything
                    -- that is trying to use one of the vim entry points will work the same way
                    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
                    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")

                    -- If the client that attached supports doc symbol providing, then attach
                    -- navic to this buffer as well
                    if client.server_capabilities.documentSymbolProvider then
                        require("nvim-navic").attach(client, bufnr)
                    end
                end,
            })

            -- Mason will take care of LSP setup; all we need to do it make any tweaks to
            -- capabilities that we'd like to see
            local default_caps =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
            require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(opts.servers) })
            require("mason-lspconfig").setup_handlers({
                function(server)
                    local server_opts = opts.servers[server] or {}
                    server_opts.capabilities = vim.tbl_deep_extend("keep", server_opts.capabilities or {}, default_caps)
                    require("lspconfig")[server].setup(server_opts)
                end,
            })

            -- Our diagnostic configuration is (currently) global, so it can be set once and done
            vim.diagnostic.config(opts.diagnostics)

            -- Set up our diagnostic signs the way that we like
            vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "", numhl = "" })
            vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "" })
            vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "" })
            vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "" })
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        keys = {
            { "<leader>um", "<cmd>Mason<cr>", desc = "LSPs/Formatters (Mason)" },
        },
        opts = {
            ensure_installed = {
                "clangd",
                "codelldb",
                "lua-language-server",
                "rust-analyzer",
                "rustfmt",
                "shellcheck",
                "shfmt",
                "stylua",
                "taplo",
            },
            ui = {
                border = "rounded",
                height = 0.8,
                width = 0.8,
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)

            -- Mason doesn't presently do automatic installs of any packages, so we simulate that
            -- ourselves when loading the plugin
            local reg = require("mason-registry")
            for _, tool in ipairs(opts.ensure_installed) do
                local p = reg.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        lazy = false,
        config = function()
            local nls = require("null-ls")

            nls.setup({
                sources = {
                    nls.builtins.code_actions.gitsigns,
                    nls.builtins.code_actions.shellcheck,
                    nls.builtins.formatting.rustfmt.with({
                        extra_args = { "--edition=2021" },
                    }),
                    nls.builtins.formatting.shfmt,
                    nls.builtins.formatting.stylua,
                    nls.builtins.formatting.taplo,
                },
            })
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            "neovim/nvim-lspconfig",
        },
        ft = "rust",
        opts = {
            server = {
                settings = {
                    ["rust-analyzer"] = require("benvim.features.lsp.rust_analyzer.settings"),
                },
            },
            tools = {
                inlay_hints = {
                    auto = true,
                },
            },
            dap = {
                adapter = {},
            },
        },
        config = function(_, opts)
            local mason_path = vim.fn.stdpath("data") .. "/mason/"
            local codelldb_path = mason_path .. "bin/codelldb"
            local liblldb_path = mason_path .. "packages/codelldb/extension/lldb/lib/liblldb.so"

            opts.dap.adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
            opts.tools.executor = require("rust-tools.executors").toggleterm

            require("rust-tools").setup(opts)
        end,
    },
}

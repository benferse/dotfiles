-- Language server integration, and all the other bits that
-- make it feel like magic

local map = require('utils').map

local function on_attach(client, buffer)
    -- Attach lsp as the omni completion source
    vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    map('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', { buffer = buffer, name = "Code action"})
    map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', { buffer = buffer, name = "Goto definition"})
    map('n', '<leader>lf', '<cmd>Telescope diagnostics bufnr=0<cr>', { buffer = buffer, name = "File diagnostics"})
    map('n', '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<cr>', { buffer = buffer, name = "Refactor: Rename" })
    map('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<cr>', { buffer = buffer, name = "Quickfix diagnostics" })
    map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>', { buffer = buffer, name = "Find references" })
    map('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { buffer = buffer, name = "Signature help"})
    map('n', '<leader>lw', '<cmd>Telescope diagnostics<cr>', { buffer = buffer, name = "Workspace diagnostics"})
    map('n', '<leader>l=', '<cmd>lua vim.lsp.buf.formatting()<cr>', { buffer = buffer, name = "Format document"})

    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    map('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { buffer = buffer, name = "Diagnostic"})
    map('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<cr>', { buffer = buffer, name = "Diagnostic"})

    require('lsp-status').on_attach(client)
end

local function get_capabilities()
    local vim_caps = vim.lsp.protocol.make_client_capabilities()
    local cmp_caps = require('cmp_nvim_lsp').update_capabilities(vim_caps)
    local lsp_caps = vim.tbl_extend('keep', cmp_caps, require('lsp-status').capabilities)

    return lsp_caps
end

local function setup_languages()
    require('nvim-lsp-installer').on_server_ready(function(server)
        local opts = {
            on_attach = on_attach,
            capabilities = get_capabilities(),
        }

        if server.name == 'sumneko_lua' then
            opts.settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    runtime = {
                        version = 'LuaJIT',
                        path = vim.split(package.path, ';')
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        }
                    }
                }
            }

            server:setup(opts)
        elseif server.name == 'rust_analyzer' then
            require('rust-tools').setup {
                server = vim.tbl_deep_extend('force', server:get_default_options(), opts)
            }
            server:attach_buffers()
        end
    end)
end

local function setup()
    vim.cmd([[
        packadd lsp-status.nvim
        packadd nvim-lspconfig
        packadd nvim-lsp-installer
        packadd rust.vim
        packadd rust-tools.nvim
    ]])

    -- Let any attached LSP servers know that we're interested in progress
    -- messages
    require('lsp-status').register_progress()

    -- Setup individual language support through the automatic LSP server installer
    setup_languages()
end

return { setup = setup }

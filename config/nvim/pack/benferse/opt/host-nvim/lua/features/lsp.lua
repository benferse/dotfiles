-- Language server integration, and all the other bits that
-- make it feel like magic

local map = require('utils').map

local function on_attach(client, bufnum)
    vim.api.nvim_buf_set_option(bufnum, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local silent = { silent = true }
    vim.api.nvim_buf_set_keymap(bufnum, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', silent)
    vim.api.nvim_buf_set_keymap(bufnum, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', silent)
    vim.api.nvim_buf_set_keymap(bufnum, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', silent)
    vim.api.nvim_buf_set_keymap(bufnum, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>', silent)
    vim.api.nvim_buf_set_keymap(bufnum, 'n', '<LocalLeader>k', '<cmd>lua vim.lsp.buf.signature_help()<cr>', silent)

    vim.api.nvim_buf_set_keymap(bufnum, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', silent)

    require('lsp-status').on_attach(client, bufnum)
end

local function setup_lua()
    local lspconfig = require('lspconfig')
    if lspconfig['lua'] then
        lspconfig['lua'].setup {
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        }
    end
end

local function setup_rust()
    -- nvim-lspinstall does not support Windows, and it doesn't look like
    -- the author ever will. So for now just assume I've gone through the
    -- work to install rust-analyzer myself there :(
    local cmd = 'rust-analyzer.exe'
    if vim.fn.has('win32') == 0 then
        local server_path = require('lspinstall/util').install_path('rust')
        cmd = server_path .. '/rust-analyzer'
    end

    require('rust-tools').setup {
        tools = {
            hover_actions = {
                border = 'rounded',
            },
        },
        server = {
            cmd = { cmd },
            on_attach = on_attach,
        },
    }
end

local function setup(args)
    vim.cmd([[
        packadd lsp-status.nvim
        packadd nvim-lspconfig
        packadd nvim-lspinstall
        packadd rust-tools.nvim
    ]])

    -- Let any attached LSP servers know that we're interested in progress
    -- messages
    require('lsp-status').register_progress()

    -- Load nvim-lspinstall so :LspInstall is available, but don't use
    -- its config to setup nvim-lsp directly, since we need to let
    -- rust-tools do that for rust-analyzer. Instead, we will manipulate
    -- the server paths ourselves using their exported functions.
    require('lspinstall').setup {}

    -- Setup individual language support
    setup_rust()
    setup_lua()

    local silent = { silent = true }
    map('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', silent)
    map('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', silent)
end

return { setup = setup }

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
    require('lspconfig')['lua'].setup {
        on_attach = on_attach
    }
end

local function setup_rust()
    -- However nvim-lsp tries to start the language server does not use
    -- standard executable resolution on Windows, so make sure we include
    -- an explicit extension there
    local ra_ext = ''
    if vim.fn.has('win32') == 1 then ra_ext = '.exe' end

    local server_path = require('lspinstall/util').install_path('rust')
    local cmd = server_path .. '/rust-analyzer' .. ra_ext

    require('rust-tools').setup {
        tools = {
            hover_actions = {
                border = 'rounded',
            },
        },
        server = {
            cmd = { server_path .. '/rust-analyzer' .. ra_ext },
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
    -- if M.setup_rust then M.setup_rust() end
    -- if V.setup_lua then V.setup_lua() end
    setup_rust()
    setup_lua()

    local silent = { silent = true }
    map('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', silent)
    map('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', silent)
end

return { setup = setup }

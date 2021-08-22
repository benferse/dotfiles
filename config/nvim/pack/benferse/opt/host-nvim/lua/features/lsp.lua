-- Language server integration, and all the other bits that
-- make it feel like magic

local map = require('utils').map

local M = {}

M.setup = function(args)
    vim.cmd([[
        packadd lsp-status.nvim
        packadd nvim-lspconfig
        packadd nvim-lspinstall
        packadd rust-tools.nvim
    ]])

    -- Native neovim LSP configuration. Explicitly not starting the
    -- rust_analyzer plugin, as rust-tools.nvim will do that for us
    -- (with our overrides)
    local lspconfig = require('lspconfig')
    local on_attach = function(client, bufnum)
        vim.api.nvim_buf_set_option(bufnum, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        vim.api.nvim_buf_set_keymap(bufnum, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', silent)
        vim.api.nvim_buf_set_keymap(bufnum, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', silent)
        vim.api.nvim_buf_set_keymap(bufnum, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', silent)
        vim.api.nvim_buf_set_keymap(bufnum, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>', silent)
        vim.api.nvim_buf_set_keymap(bufnum, 'n', '<LocalLeader>k', '<cmd>lua vim.lsp.buf.signature_help()<cr>', silent)

        vim.api.nvim_buf_set_keymap(bufnum, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', silent)

        require('lsp-status').on_attach(client, bufnum)
    end

    map('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', silent)
    map('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', silent)

    -- Let any attached LSP servers know that we're interested in progress
    -- messages
    require('lsp-status').register_progress();

    -- Load nvim-lspinstall so :LspInstall is available, but don't use
    -- its config to setup nvim-lsp directly, since we need to let
    -- rust-tools do that for rust-analyzer. Instead, we will manipulate
    -- the server paths ourselves using their exported functions.
    require('lspinstall').setup {}

    -- However nvim-lsp tries to start the language server does not use
    -- standard executable resolution on Windows, so make sure we include
    -- an explicit extension there
    local ra_ext = ''
    if vim.fn.has('win32') == 1 then ra_ext = '.exe' end

    local server_path = require('lspinstall/util').install_path('rust')

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

return M

-- Language server integration, and all the other bits that
-- make it feel like magic

local map = require('utils').map
local bufmap = require('utils').bufmap

local function on_attach(client, bufnum)
    vim.api.nvim_buf_set_option(bufnum, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local silent = { silent = true }

    bufmap(bufnum, 'n', 'gd', '<cmd>Lspsaga preview_definition<cr>', silent)
    bufmap(bufnum, 'n', 'gh', '<cmd>Lspsaga lsp_finder<cr>', silent)
    bufmap(bufnum, 'n', 'gs', '<cmd>Lspsaga signature_help<cr>', silent)
    bufmap(bufnum, 'n', 'K',  '<cmd>Lspsaga hover_doc<cr>', silent)

    bufmap(bufnum, 'n', '<Leader>ca', '<cmd>Lspsaga code_action<cr>', silent)
    bufmap(bufnum, 'x', '<Leader>ca', '<cmd>Lspsaga range_code_action<cr>', silent)
    bufmap(bufnum, 'n', '<Leader>cd', '<cmd>Lspsaga show_line_diagnostics<cr>', silent)

    bufmap(bufnum, 'n', '<Leader>rn', '<cmd>Lspsaga rename<cr>', silent)

    require('lsp-status').on_attach(client, bufnum)
end

local function setup_lua()
    local vim_caps = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim_caps)
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
            capabilities = capabilities,
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

    local vim_caps = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim_caps)

    require('rust-tools').setup {
        tools = {
            hover_actions = {
                border = 'rounded',
            },
        },
        server = {
            cmd = { cmd },
            on_attach = on_attach,
            capabilities = capabilities,
        },
    }
end

local function setup()
    vim.cmd([[
        packadd lspsaga.nvim
        packadd lsp-status.nvim
        packadd nvim-lspconfig
        packadd nvim-lspinstall
        packadd rust.vim
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

    -- Setup lspsaga for general LSP functionality
    require('lspsaga').setup {
        border_style = 'round',
        finder_action_keys = {
            open = '<CR>',
        },
        finder_definition_icon = ' ',
        finder_reference_icon = ' ',
    }

    -- Setup individual language support
    setup_rust()
    setup_lua()

    local silent = { silent = true }
    map('n', ']g', '<cmd>Lspsaga diagnostic_jump_next<cr>', silent)
    map('n', '[g', '<cmd>Lspsaga diagnostic_jump_prev<cr>', silent)

    -- Rename forward / backwards to use smart scrolling that is lspsaga aware
    map('n', '<C-f>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<cr>', silent)
    map('n', '<C-b>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<cr>', silent)
end

return { setup = setup }

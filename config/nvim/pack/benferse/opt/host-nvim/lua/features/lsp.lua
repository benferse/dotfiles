-- Language server integration, and all the other bits that
-- make it feel like magic

local map = require('utils').map

local function on_attach(client, buffer)
    -- Attach lsp as the omni completion source
    vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local wk = require('which-key')
    wk.register({
        ['gd'] = { '<cmd>lua vim.lsp.buf.definition()<cr>', "goto deffff" },
    }, { buffer = buffer })

    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { buffer = buffer, name = "goto definition" })
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { buffer = buffer, name = "find references" })
    map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { buffer = buffer, name = "signature help" })
    map('n', 'g=', '<cmd>lua vim.lsp.buf.formatting()<cr>', { buffer = buffer, name = "format document" })
--     nbufmap('gr', '<cmd>lua vim.lsp.buf.references()<cr>')
--     nbufmap('gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
--     nbufmap('g=', '<cmd>lua vim.lsp.buf.formatting()<cr>')
-- 
--     nbufmap('K',  '<cmd>lua vim.lsp.buf.hover()<cr>')
-- 
--     nbufmap('[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
--     nbufmap(']g', '<cmd>lua vim.diagnostic.goto_next()<cr>')
-- 
--     nbufmap('<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
--     nbufmap('<Leader>cd', '<cmd>lua vim.diagnostic.open_float()<cr>')
--     nbufmap('<Leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>')
-- 
    require('lsp-status').on_attach(client)
end

local function get_capabilities()
    local vim_caps = vim.lsp.protocol.make_client_capabilities()
    local cmp_caps = require('cmp_nvim_lsp').update_capabilities(vim_caps)
    local lsp_caps = vim.tbl_extend('keep', cmp_caps, require('lsp-status').capabilities)

    return lsp_caps
end

local function setup_lua()
    require('nvim-lsp-installer').on_server_ready(function(server)
        local opts = {
            on_attach = on_attach,
            capabilities = get_capabilities(),
        }

        server:setup(opts)
    end)
    -- local lspconfig = require('lspconfig')
    -- if lspconfig['lua'] then
    --     lspconfig['lua'].setup {
    --         on_attach = on_attach,
    --         settings = {
    --             Lua = {
    --                 diagnostics = {
    --                     globals = { 'vim' },
    --                 },
    --             },
    --         },
    --         capabilities = get_capabilities(),
    --     }
    -- end
end

local function setup_rust()
    -- -- nvim-lspinstall does not support Windows, and it doesn't look like
    -- -- the author ever will. So for now just assume I've gone through the
    -- -- work to install rust-analyzer myself there :(
    -- local cmd = 'rust-analyzer.exe'
    -- if vim.fn.has('win32') == 0 then
    --     local server_path = require('lspinstall/util').install_path('rust')
    --     cmd = server_path .. '/rust-analyzer'
    -- end

    require('rust-tools').setup {
        tools = {
            hover_actions = {
                border = 'rounded',
            },
        },
        server = {
            on_attach = on_attach,
            capabilities = get_capabilities(),
        },
    }
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

    -- Setup individual language support
    setup_rust()
    setup_lua()
end

return { setup = setup }

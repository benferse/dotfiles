local M = {}

local has_navic, navic = pcall(require, 'nvim-navic');
local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local has_mapx, mapx = pcall(require, 'mapx')

M.setup = function()
    local signs = {
        { name = 'DiagnosticSignError', text = '' },
        { name = 'DiagnosticSignWarn',  text = '' },
        { name = 'DiagnosticSignInfo',  text = '' },
        { name = 'DiagnosticSignHint',  text = '' },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
    end

    vim.diagnostic.config({
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = 'minimal',
            border = 'rounded',
            source = 'always',
            header = '',
            prefix = '',
        },
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded',
    })

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'rounded',
    })
end

local function get_capabilities()
    local caps = vim.lsp.protocol.make_client_capabilities()

    if has_cmp then
        caps = cmp_nvim_lsp.default_capabilities()
    end

    return caps
end

local function add_lsp_keymap(bufnr, from, to, label)
    if has_mapx then
        local opts = { buffer = bufnr, label = label, silent = true }
        mapx.nnoremap(from, to, opts)
    end
end

local function add_lsp_keymaps(bufnr)
    -- Add buffer specific keymaps
    add_lsp_keymap(bufnr, ']g', '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next diagnostic')
    add_lsp_keymap(bufnr, '[g', '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Previous diagnostic')

    add_lsp_keymap(bufnr, '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action')
    add_lsp_keymap(bufnr, '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Goto definition')
    add_lsp_keymap(bufnr, '<leader>lf', '<cmd>Telescope diagnostics bufnr=0<cr>', 'File diagnostics')
    add_lsp_keymap(bufnr, '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Refactor: rename')
    add_lsp_keymap(bufnr, '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>', 'Find references')
    add_lsp_keymap(bufnr, '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature help')
end

M.on_attach = function(client, bufnr)
    -- Attach lsp as the omni completion source for this buffer
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    add_lsp_keymaps(bufnr)

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec(
        [[
            augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]],
            false
        )
    end

    -- Make breadcrumbs if available
    if has_navic then
        navic.attach(client, bufnr)
    end

    return client
end

M.capabilities = get_capabilities()

return M

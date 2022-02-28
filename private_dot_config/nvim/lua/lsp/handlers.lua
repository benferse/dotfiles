local M = {}

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
    local vim_caps = vim.lsp.protocol.make_client_capabilities()
    local lsp_caps = vim.tbl_extend('keep', vim_caps, require('lsp-status').capabilities)

    return lsp_caps
end

M.on_attach = function(client, bufnr)
    -- Attach lsp as the omni completion source for this buffer
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Add buffer specific keymaps
    local opts = { silent = true, buffer = bufnr }
    nnoremap('K', [[<cmd>lua vim.lsp.buf.hover()<cr>]], opts)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
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

    require('lsp-status').on_attach(client)
end

M.capabilities = get_capabilities()

return M

local is_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not is_ok then
    return
end

lsp_installer.on_server_ready(function(server)
    -- Common options used across language servers, for example to
    -- handle keybinds, status and action integration, etc.
    local handlers = require('lsp.handlers')
    local opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
    }

    if server.name == "sumneko_lua" then
        local lua_opts = require('lsp.settings.sumneko_lua')
        opts = vim.tbl_deep_extend('force', lua_opts, opts)

        server:setup(opts)

    elseif server.name == 'rust_analyzer' then
        local codelldb_path = '/home/benferse/.codelldb/adapter/codelldb'
        local liblldb_path = '/home/benferse/.codelldb/lldb/lib/liblldb.so'

        require('rust-tools').setup {
            server = vim.tbl_deep_extend('force', server:get_default_options(), opts),
            dap = {
                adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
                cwd = '${workspaceFolder}',
                stopOnEntry = true,
            },
        }

        server:attach_buffers()
    end

end)

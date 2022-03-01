return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    [vim.fn.stdpath('config') .. '/lua'] = true,
                },
                maxPreload = 2000,
            },
        },
    },
}

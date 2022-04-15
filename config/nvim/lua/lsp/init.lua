-- The lspconfig package doesn't need to be initialized as
-- it only provided boilerplate configuration data, but we
-- can use its absence as a good hint that continuing won't
-- end well
local is_ok, _ = pcall(require, 'lspconfig')
if not is_ok then
    return
end

require('lsp.status')
require('lsp.handlers').setup()
require('lsp.installer')

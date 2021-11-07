-- Load extensions that are only useful when running directly
-- in the nvim host
require('features/core').setup {}

require('features/ui').setup()
require('features/git').setup()
require('features/picker').setup()
require('features/editor').setup()
require('features/lsp').setup()
require('features/terminal').setup()
require('features/navigation').setup()
require('features/theme').setup()

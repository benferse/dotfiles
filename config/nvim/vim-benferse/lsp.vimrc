"
" Configuration for the neovim native LSP support
"
if has("win32")

lua << EOF
require 'nvim_lsp'.vimls.setup { cmd = { "vim-language-server.cmd", "--stdio" } }
EOF

else

lua << EOF
require 'nvim_lsp'.vimls.setup { cmd = { "vim-language-server", "--stdio" } }
EOF

endif

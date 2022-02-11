-- Experimental treesitter support for neovim nightly (0.6+)

local function setup()
    vim.cmd([[
        packadd nvim-treesitter
        packadd nvim-treesitter-textobjects
    ]])

    require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'cmake', 'cpp', 'c_sharp', 'json', 'lua', 'rust', 'toml', 'vim' },
        highlight = { enable = true, },
        incremental_selection = { enable = true, },
        indent = { enable = true, },
    }
end

return { setup = setup }

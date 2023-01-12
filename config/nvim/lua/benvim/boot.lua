-- Bootstrap the plugin manager for initial installs. From then on,
-- it can take care of itself
local plugin_mgr = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(plugin_mgr) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        plugin_mgr,
    })
end

vim.opt.runtimepath:prepend(plugin_mgr)

-- Make sure these are set before initializing lazy, so plugin-local
-- keymaps can use them
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Direct the plugin manager to the spec that contains our plugins
-- and their config. Plugins are collected into logic "features" to
-- keep related things together and prevent a lot of overhead due to
-- cross referencing everything all over the place
require("lazy").setup({
    spec = "benvim.features",
    defaults = {
        lazy = true,
        version = "*",
    },
    install = {
        colorscheme = { "nord", "habamax", },
    },
    checker = {
        enabled = true,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>")

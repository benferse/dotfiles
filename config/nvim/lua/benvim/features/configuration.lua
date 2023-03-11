-- Set base vim options before any plugins are loaded so our preferences are
-- available to them
require("benvim.config.settings")

-- Autocmds and keymaps can be loaded lazily when the plugin manager decides
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("benvim.config.autocmds")
        require("benvim.config.keymaps")
    end,
})

-- No plugins to load here; everything is done above when this module is
-- sourced with the rest of the spec
return {}

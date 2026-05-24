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

-- Delay notifications until someone replaces vim.notify (which should happen if our
-- plugins load correctly), or after a second (in which case something is probably very
-- very wrong)
local deferred_notifications = {}
local fallback_timer = vim.loop.new_timer()
local check_replacement = vim.loop.new_check()

if fallback_timer and check_replacement then
    -- Temporary replacement for vim.notify that will just stash anything
    -- it receives
    local function defer(...)
        table.insert(deferred_notifications, vim.F.pack_len(...))
    end

    local original_notify = vim.notify
    vim.notify = defer

    local replay_deferred = function()
        -- Stop both background tasks
        fallback_timer:stop()
        check_replacement:stop()

        -- Restore vim.notify if necessary
        if vim.notify == defer then
            vim.notify = original_notify
        end

        vim.schedule(function()
            for _, notification in ipairs(deferred_notifications) do
                vim.notify(vim.F.unpack_len(notification))
            end
        end)
    end

    -- Start the task that waits for vim.notify to be replaced
    check_replacement:start(function()
        if vim.notify ~= original_notify then
            replay_deferred()
        end
    end)

    -- Start the timer that will stop waiting after a second
    fallback_timer:start(1000, 0, replay_deferred)
end

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
        colorscheme = { "nord", "habamax" },
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
    ui = {
        border = "rounded",
    },
})

vim.keymap.set("n", "<leader>ul", "<cmd>:Lazy<cr>", { desc = "Plugins (Lazy)" })

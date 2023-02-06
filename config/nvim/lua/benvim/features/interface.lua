-- Plugins that enhance the layout of the editor, window/buffer/tab/status chrome,
-- and other UI elements

local function window_number()
    return vim.api.nvim_win_get_number(0)
end

return {
    -- Status line, tab line, winbar
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "smiteshp/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                extensions = {
                    "quickfix",
                    "toggleterm",
                    {
                        winbar = {
                            lualine_a = {
                                { window_number },
                            },
                        },
                        filetypes = {
                            "neo-tree",
                        },
                    },
                },
                options = {
                    disabled_filetypes = {
                        statusline = {
                            "alpha",
                        },
                        winbar = {
                            "alpha",
                            "checkhealth",
                        },
                    },
                    globalstatus = true,
                    theme = "auto",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        { require("nvim-navic").get_location, require("nvim-navic").is_available },
                    },
                    lualine_x = {},
                    lualine_y = {
                        {
                            "diagnostics",
                            sources = {
                                "nvim_workspace_diagnostic",
                            },
                        },
                    },
                    lualine_z = {
                        { "tabs" },
                    },
                },
                inactive_sections = {
                    lualine_a = { window_number },
                },
                winbar = {
                    lualine_a = {
                        { window_number },
                        { "filetype", icon_only = true, component_separators = { left = "", right = "", }, },
                        { "filename" },
                    },
                    lualine_y = {
        
                        {
                            "diagnostics",
                            sources = {
                                "nvim_diagnostic",
                            },
                        },
                    },
                    lualine_z = {
                        { "location" },
                    },
                },
                inactive_winbar = {
                    lualine_a = {
                        { window_number },
                    },
                    lualine_b = {
                        { "filetype", icon_only = true, component_separators = { left = "", right = "", }, },
                        { "filename" },
                    },
                    lualine_z = {
                        { "location" },
                    },
                },
            })
        end,
    },
    -- Prettier replacement for vim.notify
    {
        "rcarriga/nvim-notify",
        keys = {
            { "<leader>nd", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Clear notifications" },
        },
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },
    -- Prettier vim.ui.select and vim.ui.input
    {
        "stevearc/dressing.nvim",
        init = function()
            -- We are setting this twice, but that is indeed the point
            ---@diagnostic disable-next-line duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" }})
                return vim.ui.select(...)
            end

            -- We are setting this twice, but that is indeed the point
            ---@diagnostic disable-next-line duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" }})
                return vim.ui.input(...)
            end
        end,
    },
    -- Prettier replacements for cmdline, notifications, and messages
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            messages = {
                enabled = true,
                view = "notify",
                view_error = "notify",
                view_warn = "notify",
                view_history = "messages",
                view_search = "virtualtext",
            },
            popupmenu = {
                enabled = true,
                backend = "nui",
            },
            presets = {
                command_palette = {
                    views = {
                        cmdline_popup = {
                            position = {
                                row = 10,
                            },
                        },
                        popupmenu = {
                            position = {
                                row = 13,
                            },
                        },
                    },
                },
                lsp_doc_border = true,
            },
            notify = {
                enabled = true,
                view = "notify",
            },
        },
        keys = {
            { "<C-f>", function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end, silent = true, expr = true },
            { "<C-b>", function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end, silent = true, expr = true },
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect cmdline" },
        },
    },
    {
        "goolord/alpha-nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = "VimEnter",
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            local theta = require("alpha.themes.theta")
            local v = vim.version() or { major = 0, minor = 0, patch = 0 }

            return {
                layout = {
                    { type = "padding", val = 2 },
                    {
                        type = "text",
                        val = "benvim v2023 / neovim " .. v.major .. "." .. v.minor .. "." .. v.patch,
                        opts = { position = "center", hl = "Type" }
                    },
                    { type = "padding", val = 2 },
                    {
                        type = "group",
                        val = {
                            {
                                type = "text",
                                val = "recent files",
                                opts = {
                                    hl = "SpecialComment",
                                    shrink_margin = false,
                                    position = "center",
                                },
                            },
                            { type = "padding", val = 1, },
                            {
                                type = "group",
                                val = function()
                                    return { theta.mru(0, vim.fn.getcwd()) }
                                end,
                                opts = { shrink_margin = false },
                            },
                        },
                    },
                    { type = "padding", val = 2 },
                    {
                        type = "group",
                        val = {
                            { type = "text", val = "shortcuts", opts = { hl = "SpecialComment", position = "center" } },
                            { type = "padding", val = 1 },
                            dashboard.button("SPC b e", "New file", "<cmd>enew<cr>"),
                            dashboard.button("SPC f f", "Choose file"),
                            dashboard.button("SPC f p", "Choose project"),
                            dashboard.button("SPC u l", "Update plugins"),
                            dashboard.button("SPC q q", "Quit", "<cmd>qa<cr>"),
                        },
                        position = "center",
                    },
                    { type = "padding", val = 2 },
                    footer = {
                        type = "text",
                        val = "⚡ benvim: loading plugins",
                        opts = { position = "center" },
                    },
                },
            }
        end,
        config = function(_, opts)
            require("alpha").setup(opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    opts.layout.footer.val = "⚡ benvim: loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },
}

-- Utilities for searching across files, source control, nvim metadata, and a
-- host of other things

local lib = require("benvim")

local function telescope_from_root(picker)
    return function()
        require("telescope.builtin")[picker]({ cwd = lib.get_root() })
    end
end

return {
    -- Fuzzy find all the things with Telescope
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            { "<leader>fb", "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
            { "<leader>ff", telescope_from_root("find_files"),              desc = "Find files" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                  desc = "Recent files" },
            { "<leader>fc", "<cmd>Telescope git_commits<cr>",               desc = "Search commits" },
            { "<leader>fs", "<cmd>Telescope git_status<cr>",                desc = "Pending changes" },
            { "<leader>fm", "<cmd>Telescope marks<cr>",                     desc = "Marks" },
            { "<leader>hh", "<cmd>Telescope help_tags<cr>",                 desc = "Help tags" },
            { "<leader>hm", "<cmd>Telescope man_pages<cr>",                 desc = "Man pages" },
            { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "In current buffer" },
            { "<leader>sf", telescope_from_root("live_grep"),               desc = "In files (root)" },
        },
        opts = {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                winblend = 10,
                mappings = {
                    i = {
                        ["<esc>"] = function(...)
                            require("telescope.actions").close(...)
                        end,
                        ["jj"] = function(...)
                            require("telescope.actions").close(...)
                        end,
                        ["kj"] = function(...)
                            require("telescope.actions").close(...)
                        end,
                    },
                },
            },
        },
    },
    -- Search and replace across files
    {
        "windwp/nvim-spectre",
        keys = {
            {
                "<leader>sr",
                function()
                    require("spectre").open()
                end,
                desc = "Replace in files (Spectre)",
            },
        },
    },
}

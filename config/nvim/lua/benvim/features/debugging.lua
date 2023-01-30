return {
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        keys = {
            { "<F5>", function() require("dap").continue() end, desc = "Continue" },
            { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            { "<F10>", function() require("dap").step_over() end, desc = "Step over" },
            { "<F11>", function() require("dap").step_into() end, desc = "Step into" },
            { "<S-F11>", function() require("dap").step_out() end, desc = "Step out" },
        },
        config = function()
            -- Hide the REPL buffer from the active list. I only really want to see it when toggling
            -- dap-ui anyway
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dap-repl",
                callback = function(args)
                    vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
                end,
            })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        event = "VeryLazy",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            dap.listeners.after.event_terminated["dapui_config"] = function()
                dapui.close()
            end

            dap.listeners.after.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
        keys = {
            { "<leader>vd", function() require("dapui").toggle() end, desc = "Debugger" },
        },
    },
}

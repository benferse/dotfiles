local terminals = {}

local function toggle(name, cmd)
    local term = terminals[name]
    if term == nil then
        term = require("toggleterm.terminal").Terminal:new({
            cmd = cmd or name,
            dir = 'git_dir',
            direction = 'float',
        })

        terminals[name] = term
    end

    if term ~= nil then
        term:toggle()
    end
end

return {
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        opts = {
            open_mapping = [[\]],
            hide_numbers = true,
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = false,
            persist_size = true,
            direction = 'float',
            size = function(term)
                if term.direction == 'horizontal' then
                    return 15
                elseif term.direction == 'vertical' then
                    return vim.o.columns * 0.4
                elseif term.direction == 'float' then
                    return nil
                end
            end,
            close_on_exit = true,
            float_opts = {
                border = 'rounded',
                height = function() return math.floor(vim.o.lines * 0.8) end,
                width = function() return math.ceil(vim.o.columns * 0.8) end,
            },
        },
        keys = {
            { "<leader>vg", function() toggle("lazygit") end, desc = "lazygit" },
            { "<leader>vp", function() toggle("btop") end, desc = "Profiler (btop)" },
        }
    }
}

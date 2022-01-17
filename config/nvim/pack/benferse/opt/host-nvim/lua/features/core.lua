-- Core plugins and functionality the other features may
-- rely on

local function setup()
    vim.cmd([[
        packadd plenary.nvim
        packadd popup.nvim
        packadd which-key.nvim
    ]])
end

return { setup = setup }

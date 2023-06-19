local M = {}

function M.check()
    vim.health.report_start("benvim")
    if vim.fn.has("nvim-0.9.0") then
        vim.health.report_ok("Using Neovim >= 0.9.0")
    else
        vim.health.report_warn("This has only been tested with Neovim 0.8 and above!")
    end

    for _, cmd in ipairs({ "git", "rg", "fd", "lazygit", "btop" }) do
        if vim.fn.executable(cmd) == 1 then
            local h = io.popen(cmd .. " --version")
            if h ~= nil then
                local v = h:read("*l")
                h:close()
                vim.health.report_ok(("`%s --version` returns: %s"):format(cmd, v))
            else
                vim.health.report_error("Couldn't run " .. cmd)
            end
        else
            vim.health.report_warn(("`%s` is not installed"):format(cmd))
        end
    end
end

return M

local M = {}

function M.check()
    vim.health.report_start("benvim")

    for _, cmd in ipairs({ "git", "rg", "fd", "lazygit", "btop" }) do
        if vim.fn.executable(cmd) == 1 then
            vim.health.report_ok(("`%s` is installed"):format(cmd))
        else
            vim.health.report_warn(("`%s` is not installed"):format(cmd))
        end
    end
    vim.health.report_ok("We got this")
end

return M

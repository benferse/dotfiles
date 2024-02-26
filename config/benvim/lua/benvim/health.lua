local M = {}

-- Avoid deprecation warnings for older health check functions if we're not running
-- 0.10 or higher
local v10 = vim.fn.has("nvim-0.10.0")

local function start(name) if v10 then vim.health.start(name) else vim.health.report_start(name) end end
local function ok(msg) if v10 then vim.health.ok(msg) else vim.health.report_ok(msg) end end
local function info(msg) if v10 then vim.health.info(msg) else vim.health.report_info(msg) end end
local function warn(msg) if v10 then vim.health.warn(msg) else vim.health.report_warn(msg) end end
local function error(msg) if v10 then vim.health.error(msg) else vim.health.report_error(msg) end end

function M.check()
    start("benvim")

    if vim.fn.has("nvim-0.10.0") then
        ok("Using Neovim >= 0.10.0 (best experience)")
    elseif vim.fn.has("nvim-0.9.0") then
        info("Using Neovim >= 0.9.0 works but >= 0.10.0 is better")
    else
        warn("This has only been tested with Neovim 0.9 and above!")
    end

    for _, cmd in ipairs({ "git", "rg", "fd", "lazygit", "btop" }) do
        if vim.fn.executable(cmd) == 1 then
            local h = io.popen(cmd .. " --version")
            if h ~= nil then
                local v = h:read("*l")
                h:close()
                ok(("`%s --version` returns: %s"):format(cmd, v))
            else
                error("Couldn't run " .. cmd)
            end
        else
            warn(("`%s` is not installed"):format(cmd))
        end
    end
end

return M

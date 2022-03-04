local is_ok, alpha = pcall(require, 'alpha')
if not is_ok then
    return
end

local dashboard = require('alpha.themes.dashboard')

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function fortune()
    local handle = io.popen('fortune')
    local text = handle:read('*a')
    handle:close()
    return text
end

dashboard.section.footer.val = fortune()

alpha.setup(dashboard.opts)

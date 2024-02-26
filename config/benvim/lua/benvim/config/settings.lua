-- This file is loaded by the "configuration" plugin spec

local set = vim.opt

-- Note that the lua bridge only exposes a single boolean for each
-- value, instead of separate X and noX values. So instead of setting
-- noX, you set X = false.
--
-- See ':help option-list' for an index of individual options

set.autoindent = true
set.autowrite = true
set.backspace = { "indent", "eol", "start" }
set.backup = false
set.clipboard = "unnamedplus"
set.cmdheight = 1
set.completeopt = "menu,menuone,noselect"
set.conceallevel = 3
set.confirm = true
set.cursorline = true
set.expandtab = true
set.formatoptions = "jcroqlnt"
set.grepformat = "%f:%l:%c:%m"
set.grepprg = "rg --vimgrep"
set.hidden = true
set.hlsearch = true
set.ignorecase = true
set.inccommand = "nosplit"
set.incsearch = true
set.joinspaces = false
set.laststatus = 2
set.list = true
set.mouse = "nvi"
set.number = true
set.pumblend = 10
set.pumheight = 10
set.relativenumber = true
set.ruler = true
set.scrolloff = 4
set.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
set.shiftround = true
set.shiftwidth = 4
set.shortmess = set.shortmess + "ci"
set.showcmd = false
set.showmatch = true
set.showmode = false
set.sidescrolloff = 8
set.signcolumn = "yes:2"
set.smartcase = true
set.smartindent = true
set.smarttab = true
set.spelllang = { "en" }
set.splitbelow = true
set.splitright = true
set.tabstop = 4
set.termguicolors = true
set.timeoutlen = 300
set.undofile = true
set.undolevels = 10000
set.updatetime = 100
set.wildignore = { "*/tmp/*", "*.so", "*.swp", "*.zip", "*\\tmp\\*", "*.exe", "*.dll" }
set.wildmenu = true
set.wildmode = "longest:full,full"
set.wrap = false
set.writebackup = false

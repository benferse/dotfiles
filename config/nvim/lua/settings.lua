local set = vim.opt
local cmd = vim.cmd

local function setup()
    set.wrap = false
    set.showmatch = true
    set.signcolumn = 'yes:2'

    set.cmdheight = 1
    set.showcmd = false
    set.updatetime = 100

    set.hidden = true
    set.backup = false
    set.writebackup = false

    set.hlsearch = true
    set.incsearch = true
    set.ignorecase = true
    set.wildignore = { '*/tmp/*', '*.so', '*.swp', '*.zip', '*\\tmp\\*', '*.exe', '*.dll' }

    set.autoindent = true
    set.backspace = { 'indent', 'eol', 'start' }
    set.expandtab = true
    set.shiftwidth = 4
    set.smarttab = true
    set.tabstop = 4

    set.laststatus = 2
    set.showmode = false
    set.ruler = true
    set.wildmenu = true

    set.mouse = 'nvi'

    set.shortmess = set.shortmess + 'ci'

    set.scrolloff = 1
    set.sidescrolloff = 5

    set.autowrite = true

    cmd([[filetype plugin indent on]])
end

return { setup = setup }

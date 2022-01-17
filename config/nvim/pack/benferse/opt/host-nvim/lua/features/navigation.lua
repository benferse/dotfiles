-- Navigation plugin configuration, keybind documentation,
-- and other bits for jumping about

local function setup()
    vim.cmd([[
        packadd which-key.nvim
    ]])

    local which_key = require('which-key')
    which_key.setup {
        window = {
            border = 'none',
            position = 'bottom',
        },
        triggers = 'auto',
        triggers_blacklist = {
            i = { 'j', 'k' },
            v = { 'j', 'k' },
        },
    }

    which_key.register  {
        ["<leader>b"] = {
            name = "buffers",
            d = "Hide",
            e = "Empty",
            n = "Next",
            p = "Previous",
            x = "Wipeout",
        },
        ["<leader>f"] = {
            name = "fuzzy",
            b = "Buffers",
            f = "Files",
            r = "Recent",
            s = "Projects",
        },
        ["<leader>g"] = {
            name = "git",
            b = "Blame current line",
            p = "Preview hunk",
            r = "Reset hunk",
            R = "Reset buffer",
            s = "Stage hunk",
            S = "Stage buffer",
            u = "Unstage hunk",
            U = "Unstage buffer",
        },
        ["<leader>s"] = {
            name = "search",
            f = "In files",
            ["."] = "Current word",
        },
        ["<leader>t"] = {
            name = "terminal",
            g = "git",
        }
        ["["] = {
            name = "unimpaired",
            ["<C-L>"] = "Location file",
            ["<C-Q>"] = "Quickfix file",
            ["<C-T>"] = "Preview tag",
            ["<Space>"] = "Blank line above",
            a = "Previous arg",
            A = "First arg",
            b = "Previous buffer",
            B = "First buffer",
            c = "Previous Git hunk",
            C = "C encode",
            e = "Move line up",
            f = "Previous file in dir",
            l = "Previous location",
            L = "First location",
            n = "Previous conflict",
            o = {
                name = "Enable option",
                b = "background=light",
                c = "cursorline",
                d = "diffthis",
                e = "spell",
                h = "hlsearch",
                i = "ignorecase",
                l = "list",
                n = "number",
                r = "relativenumber",
                u = "cursorcolumn",
                v = "virtualedit",
                w = "wrap",
                x = "crosshairs",
            },
            p = "Put before",
            P = "Put above",
            q = "Previous quickfix",
            Q = "First quickfix",
            s = "Previous misspelling",
            t = "Previous tag",
            T = "First tag",
            u = "URL encode",
            w = "Previous trailing ws",
            x = "XML encode",
            y = "String encode",
        },
        ["]"] = {
            name = "Unimpaired",
            ["<C-L>"] = "Location file",
            ["<C-Q>"] = "Quickfix file",
            ["<C-T>"] = "Preview tag",
            ["<Space>"] = "Blank line below",
            a = "Next arg",
            A = "Last arg",
            b = "Next buffer",
            B = "Last buffer",
            c = "Next Git hunk",
            C = "C encode",
            e = "Move line down",
            f = "Next file in dir",
            l = "Next location",
            L = "Last location",
            n = "Next conflict",
            o = {
                name = "Disable option",
                b = "background=dark",
                c = "nocursorline",
                d = "diffoff",
                e = "nospell",
                h = "nohlsearch",
                i = "noignorecase",
                l = "nolist",
                n = "nonumber",
                r = "norelativenumber",
                u = "nocursorcolumn",
                v = "novirtualedit",
                w = "nowrap",
                x = "nocrosshairs",
            },
            p = "Put after",
            P = "Put below",
            q = "Next quickfix",
            Q = "Last quickfix",
            s = "Next misspelling",
            t = "Next tag",
            T = "Last tag",
            u = "URL decode",
            w = "Next trailing ws",
            x = "XML decode",
            y = "String decode",
        }
    }

end

return { setup = setup }

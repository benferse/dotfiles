local is_ok, which_key = pcall(require, 'which-key')
if not is_ok then
    return
end

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

--which_key.register({
--    ["<leader>b"] = { name = "Buffers" },
--    ["<leader>f"] = { name = "Fuzzy find" },
--    ["<leader>g"] = { name = "Git" },
--    ["<leader>l"] = { name = "LSP" },
--    ["<leader>s"] = { name = "Search" },
--    ["<leader>t"] = { name = "Terminals" },
--    ["<leader>w"] = {
--        name = "Window",
--        c = "Close",
--        h = "Left",
--        j = "Down",
--        k = "Up",
--        l = "Right",
--        o = "Only",
--    }
--})
--
--which_key.register({
--    ["a"] = {
--        c = "Class/struct (treesitter)",
--        f = "Function/method (treesitter)",
--    },
--    ["i"] = {
--        c = "Class/struct (treesitter)",
--        f = "Function/method (treesitter)",
--    },
--}, { mode = 'o' })
--
--which_key.register {
--    ["["] = {
--        name = "unimpaired",
--        ["<C-L>"] = "Location file",
--        ["<C-Q>"] = "Quickfix file",
--        ["<C-T>"] = "Preview tag",
--        ["<Space>"] = "Blank line above",
--        ["["] = "Class/struct start",
--        ["]"] = "Class/struct end",
--        a = "Previous arg",
--        A = "First arg",
--        b = "Previous buffer",
--        B = "First buffer",
--        c = "Previous Git hunk",
--        C = "C encode",
--        e = "Move line up",
--        f = "Previous file in dir",
--        l = "Previous location",
--        L = "First location",
--        n = "Previous conflict",
--        o = {
--            name = "Enable option",
--            b = "background=light",
--            c = "cursorline",
--            d = "diffthis",
--            e = "spell",
--            h = "hlsearch",
--            i = "ignorecase",
--            l = "list",
--            n = "number",
--            r = "relativenumber",
--            u = "cursorcolumn",
--            v = "virtualedit",
--            w = "wrap",
--            x = "crosshairs",
--        },
--        p = "Put before",
--        P = "Put above",
--        q = "Previous quickfix",
--        Q = "First quickfix",
--        s = "Previous misspelling",
--        t = "Previous tag",
--        T = "First tag",
--        u = "URL encode",
--        w = "Previous trailing ws",
--        x = "XML encode",
--        y = "String encode",
--    },
--    ["]"] = {
--        name = "Unimpaired",
--        ["<C-L>"] = "Location file",
--        ["<C-Q>"] = "Quickfix file",
--        ["<C-T>"] = "Preview tag",
--        ["<Space>"] = "Blank line below",
--        ["]"] = "Class/struct start",
--        ["["] = "Class/struct end",
--        a = "Next arg",
--        A = "Last arg",
--        b = "Next buffer",
--        B = "Last buffer",
--        c = "Next Git hunk",
--        C = "C encode",
--        e = "Move line down",
--        f = "Next file in dir",
--        l = "Next location",
--        L = "Last location",
--        n = "Next conflict",
--        o = {
--            name = "Disable option",
--            b = "background=dark",
--            c = "nocursorline",
--            d = "diffoff",
--            e = "nospell",
--            h = "nohlsearch",
--            i = "noignorecase",
--            l = "nolist",
--            n = "nonumber",
--            r = "norelativenumber",
--            u = "nocursorcolumn",
--            v = "novirtualedit",
--            w = "nowrap",
--            x = "nocrosshairs",
--        },
--        p = "Put after",
--        P = "Put below",
--        q = "Next quickfix",
--        Q = "Last quickfix",
--        s = "Next misspelling",
--        t = "Next tag",
--        T = "Last tag",
--        u = "URL decode",
--        w = "Next trailing ws",
--        x = "XML decode",
--        y = "String decode",
--    }
--}
--

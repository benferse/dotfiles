-- This file is loaded by the "configuration" plugin spec
--
-- Keymaps in this file are not plugin-specific, and will use basic vim/nvim features or
-- our own functions. Well, built-in features. No promise on whether they're basic :)

-- Escape back to normal mode without having to stretch
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("i", "jj", "<esc>")

-- Always prefer display lines over text lines when moving up and down, unless
-- we're given a count of lines (which probably means you're navigating using
-- the number line
vim.keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Undo breakpoints for code editing. Insert logical places to "undo" to within a single
-- line
vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("i", ";", ";<C-g>u")

-- This is honestly life changing. I can't believe I lived
-- for over forty years without this
vim.keymap.set("n", ";", "<cmd>up<cr>")

-- Use n and N to consistently move forward and backward, regardless of whether you used / or
-- ? to initiate the search. See https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true })

-- Clear search highlighting with Alt-L
-- Courtesy of the inimitable tpope
vim.keymap.set(
    "n",
    "<A-l>",
    [[:<C-u>nohlsearch<Bar>mes clear<Bar><C-R>=has('diff')?'diffupdate':'mode'<cr><cr>]],
    { silent = true }
)

-- Don't lose the selection when shifting left or right.
-- See https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- While already in insert mode, move to the end of the next line and continue editing,
-- or open a new like and continue editing, both of which come up more often than you'd think
vim.keymap.set("i", "<S-CR>", "<C-O><cmd>normal 2g_A<cr>")
vim.keymap.set("i", "<C-CR>", "<cmd>normal! o<cr>")

-- Move lines up or down
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move down" })

-- Resize the current window using Shift+Arrow keys
vim.keymap.set({ "i", "n" }, "<S-Up>", "<cmd>resize +2<cr>")
vim.keymap.set({ "i", "n" }, "<S-Down>", "<cmd>resize -2<cr>")
vim.keymap.set({ "i", "n" }, "<S-Right>", "<cmd>vertical resize +2<cr>")
vim.keymap.set({ "i", "n" }, "<S-Left>", "<cmd>vertical resize -2<cr>")

-- Navigate using CTRL-hjkl, pretty much regardless of mode. Note that insert and terminal
-- mode mappings intentionally do not use <cmd> because we *want* the mode change
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<cr>")

vim.keymap.set({ "i", "t" }, "<C-h>", [[<C-\><C-n>:<C-u>wincmd h<cr>]])
vim.keymap.set({ "i", "t" }, "<C-j>", [[<C-\><C-n>:<C-u>wincmd j<cr>]])
vim.keymap.set({ "i", "t" }, "<C-k>", [[<C-\><C-n>:<C-u>wincmd k<cr>]])
vim.keymap.set({ "i", "t" }, "<C-l>", [[<C-\><C-n>:<C-u>wincmd l<cr>]])

-- Use H and L to switch buffers, since I never use what they do by default
vim.keymap.set({ "n", "v" }, "H", "<cmd>bprev<cr>")
vim.keymap.set({ "n", "v" }, "L", "<cmd>bnext<cr>")

-- Leader-based mappings follow spacevim/etc. style conventions, where the first character
-- after <leader> is generally collection of related commands:
--
-- <Tab> - Tabs
-- b - Buffers
-- c - Code
-- f - Files / fuzzy
-- g - Git
-- h - Help
-- n - Notifications / messages
-- q - Quit / Save / Restore sessions
-- s - Search / replace
-- t - Toggle settings on / off
-- u - Plugins / extensions / updates
-- v - Views
-- w - Window navigation
-- x - Issues (Trouble / quickfix / location list)
vim.keymap.set("n", "<leader>be", "<cmd>enew<cr>", { desc = "New" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "Prev" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code action" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "LSP: Line diagnostics" })
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "LSP: Format" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP: Rename" })

vim.keymap.set("n", "<leader>hq", "<cmd>helpclose<cr>", { desc = "Close help window" })

vim.keymap.set("n", "<leader>qq", "<cmd>qall<cr>", { desc = "Quit without saving" })
vim.keymap.set("n", "<leader>qw", "<cmd>xall<cr>", { desc = "Save all and quit" })

vim.keymap.set("n", "<leader>uh", "<cmd>checkhealth<cr>", { desc = "Health checks" })

if vim.fn.has("nvim-0.9.0") == 1 then
    vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect" })
end

vim.keymap.set("n", "<leader>wh", "<cmd>wincmd h<cr>", { desc = "Go left" })
vim.keymap.set("n", "<leader>wj", "<cmd>wincmd j<cr>", { desc = "Go down" })
vim.keymap.set("n", "<leader>wk", "<cmd>wincmd k<cr>", { desc = "Go up" })
vim.keymap.set("n", "<leader>wl", "<cmd>wincmd l<cr>", { desc = "Go right" })

vim.keymap.set("n", "<leader>wc", "<C-w>c", { desc = "Close" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Only" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split (horizontal)" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split (vertical)" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Quit" })

local function toggle_qf()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        for _, win_info in ipairs(vim.fn.getwininfo(win)) do
            if win_info.quickfix == 1 then
                vim.cmd[[close]]
                return
            end
        end
    end

    vim.cmd[[botright copen]]
end

vim.keymap.set("n", "<leader>xq", toggle_qf, { desc = "Quickfix" })

local function toggle_loclist()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        for _, win_info in ipairs(vim.fn.getwininfo(win)) do
            if win_info.loclist == 1 then
                vim.cmd[[lclose]]
                return
            end
        end
    end

    local _, _ = pcall(vim.cmd, "horizontal lopen")
end

vim.keymap.set("n", "<leader>xl", toggle_loclist, { desc = "Location list" })

vim.keymap.set("n", "<leader><Tab>e", "<cmd>tabnew<cr>", { desc = "New" })
vim.keymap.set("n", "<leader><Tab>n", "gt", { desc = "Next" })
vim.keymap.set("n", "<leader><Tab>p", "gT", { desc = "Prev" })
vim.keymap.set("n", "<leader><Tab>q", "<cmd>tabclose<cr>", { desc = "Close" })

for i = 1, 9, 1 do
    vim.keymap.set("n", "<leader>" .. i, i .. "<C-w>w", { desc = "Goto window " .. i })
end

-- Mappings that start with [ and ] generally come in pairs and involve next/prev or fwd/back
-- navigations that come in pairs, a la vim-unimpaired, etc.
vim.keymap.set({ "n", "v" }, "]<Tab>", "gt", { desc = "Tab page" })
vim.keymap.set({ "n", "v" }, "[<Tab>", "gT", { desc = "Tab page" })

vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next" })
vim.keymap.set("n", "[b", "<cmd>bprev<cr>", { desc = "Prev" })

-- [c and ]c move between diff chunks in diffmode, but wouldn't it be nice if
-- they also worked for git diffs in non-diff mode so a diff is a diff? I agree.
vim.keymap.set("n", "]c", [[&diff ? ']c' : ']h']], { expr = true, desc = "Difference", remap = true })
vim.keymap.set("n", "[c", [[&diff ? '[c' : '[h']], { expr = true, desc = "Difference", remap = true })

-- Jump to diagnostic locations. Using the new vim diagnostics API, so this is not
-- necessarily LSP-driven
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostic" })

-- Location list navigation
vim.keymap.set("n", "]l", "<cmd>lnext<cr>", { desc = "Next location" })
vim.keymap.set("n", "[l", "<cmd>lprev<cr>", { desc = "Prev location" })
vim.keymap.set("n", "]L", "<cmd>llast<cr>", { desc = "Last location" })
vim.keymap.set("n", "[L", "<cmd>lfirst<cr>", { desc = "First location" })

-- Quickfix list navigation
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Prev quickfix" })
vim.keymap.set("n", "]Q", "<cmd>clast<cr>", { desc = "Last quickfix" })
vim.keymap.set("n", "[Q", "<cmd>cfirst<cr>", { desc = "First quickfix" })

-- Insert blank lines above / below the current position, accepting a count,
-- and leaving the cursor where it is
vim.keymap.set(
    { "n", "v" },
    "]<Space>",
    "<cmd>call append(line('.'), repeat([''], v:count1))<cr>",
    { desc = "Blank line(s) below" }
)
vim.keymap.set(
    { "n", "v" },
    "[<Space>",
    "<cmd>call append(line('.') - 1, repeat([''], v:count1))<cr>",
    { desc = "Blank line(s) above" }
)

-- Custom textobjects for the entire document (mnemonic "an everything" :))
local function entire_buffer_textobj()
    local mode = vim.api.nvim_get_mode().mode
    local is_visual = string.lower(string.sub(mode, 1, 1)) == "v"

    vim.fn.execute("normal! m`")
    vim.fn.execute("keepjumps normal! gg0")
    vim.fn.execute("normal! " .. (is_visual and "o" or "V"))
    vim.fn.execute("keepjumps normal! G$")
end

vim.keymap.set({ "o", "x" }, "ae", entire_buffer_textobj, { desc = "Entire buffer" })

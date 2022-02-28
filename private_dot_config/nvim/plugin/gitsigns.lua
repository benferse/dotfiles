local is_ok, gitsigns = pcall(require, 'gitsigns')
if not is_ok then
    return
end

gitsigns.setup {
    keymaps = {
        -- Default keymap options
        noremap = true,
    },
    preview_config = {
        border = 'rounded',
    },
    signs = {
        add = { hl = 'GitGutterAdd', text = '+' },
        change = { hl = 'GitGutterChange', text = '~' },
        delete = { hl = 'GitGutterDelete', text = '_' },
        topdelete = { hl = 'GitGutterDelete', text = '‾' },
        changedelete = { hl = 'GitGutterChange', text = '~' },
    },
}

--map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'", { expr = true })
--map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'", { expr = true })
--
--map('n', '<leader>go', '<cmd>Telescope git_status<cr>', 'Browse status')
--map('n', '<leader>gb', '<cmd>Telescope git_status<cr>', 'Browse branches')
--map('n', '<leader>gc', '<cmd>Telescope git_status<cr>', 'Browse commits')
--map('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', 'Diff')
--
--map('nv', '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', 'Reset hunk')
--map('nv', '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', 'Stage hunk')
--
--map('n', '<leader>gR', '<cmd>Gitsigns reset_buffer<cr>', 'Reset buffer')
--map('n', '<leader>gS', '<cmd>Gitsigns stage_buffer<cr>', 'Stage buffer')
--
--map('n', '<leader>gu', '<cmd>Gitsigns undo_stage_hunk<cr>', 'Unstage hunk')
--map('n', '<leader>gU', '<cmd>Gitsigns reset_buffer_index<cr>', 'Reset buffer from index')
--
--map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<cr>', 'Preview hunk')
--map('n', '<leader>gb', '<cmd>lua require"gitsigns".blame_line{full=true}<cr>', 'Blame line')
--
--map('o', 'ih', ':<C-U>Gitsigns select_hunk<cr>', 'Hunk')
--map('x', 'ih', ':<C-U>Gitsigns select_hunk<cr>', 'Hunk')

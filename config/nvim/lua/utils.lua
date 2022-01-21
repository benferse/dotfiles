--
-- Small utilities to make common configuration patterns with
-- the vimscript bridge accessible across modules
--
local api = vim.api
local cmd = vim.cmd
local wk_loaded, wk = pcall(require, 'which-key')

--
-- Creates a key mapping. This is a convenience for calling ':help nvim_set_keymap' or
-- ':help nvim_buf_set_keymap', either directly or via 'which-key'
--
-- The arguments are mostly the same as those of nvim_set_keymap, with some
-- conveniences thrown in.
--
-- modes - Which mapmode(s) should the mapping be set for. This can either
--         be a single string (e.g. 'n'), or a table to set multiple modes at once
--         (e.g. {'n', 'v', 'o'})
-- lhs - The keysequence to map. Keycodes (':help keycodes') are expanded as expected.
-- rhs - The resulting keysequence. Keycodes (':help keycodes') are expanded as expected.
-- opts - Any map arguments to include, including "name", which is passed to which-key if
--        that ends up being used. As a shorthand, opts can be a string, and this will be
--        used as the name directly. See ':help map-arguments'.
--
local function map(modes, lhs, rhs, opts)
    local name = ''

    -- If opts is just a string, then use it as the friendly name text
    if type(opts) == 'string' then
        name = opts
        opts = {}
    else
        -- Options are, indeed, optional. Name is synthetic and just used
        -- in case we need both opts and a name for which-key, so extract it
        -- before passing opts along
        opts = opts or {}
        name = opts.name or ''
        opts.name = nil
    end

    -- Default to a silent, noremap mapping, since that's 99% of what I end up doing anyway.
    -- You can always pass { noremap = false } in the other 1%
    opts.noremap = opts.noremap == nil and true or opts.noremap
    opts.silent = opts.silent == nil and true or opts.silent
    opts.nowait = opts.nowait == nil and true or opts.nowait

    -- Expand a single argument mode to a table
    if type(modes) == 'string' then
        modes = {modes}
    end

    -- Call the bridge function to create a mapping for each mode
    for _, mode in ipairs(modes) do
        if wk_loaded then
            -- which-key.nvim is available, so let it do the mapping
            -- while it records the name for navigation help
            opts.mode = mode

            -- Make sure that terminal mode mappings get input
            -- that is preprocessed for terminal codes and keycodes
            if mode == 't' then
                rhs = api.nvim_replace_termcodes(rhs, true, true, true)
            end

            wk.register({ [lhs] = { rhs, name }, }, opts)
        else
            -- which-key is not available, so call the nvim API directly.
            -- Figure out if the global or per-buffer function is needed.
            if opts.buffer == nil then
                api.nvim_set_keymap(mode, lhs, rhs, opts)
            else
                local buffer = opts.buffer
                opts.buffer = nil
                api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
            end
        end
    end
end

--
-- Registers a set of auto-commands and assigns them to a group. This
-- is a convenience wrapper for invoking ':help augroup' and ':help autocmd'
-- until the vimscript bridge has first class support for this
--
-- name - The name of the group to associate the commands with
-- commands - One (as a string) or more (as a table of strings) commands to
--            register. These are passed as-is to ':help autocmd'
local function augroup(name, commands, delete)
    -- Deleting existing commands is optional, and by default we will not
    delete = delete == nil and false or delete

    -- Expand a single command to a table
    if type(commands) == 'string' then
        commands = { commands }
    end

    -- Start the group, and then clear it if requested
    cmd('augroup ' .. name)
    if delete then
        cmd([[autocmd!]])
    end

    -- Add each of the requested commands
    for _, command in ipairs(commands) do
        cmd('autocmd ' .. command)
    end

    -- Restore the default group for subsequent auto commands
    cmd([[augroup END]])
end

return { augroup = augroup, map = map }

--
-- Small utilities to make common configuration patterns with
-- the vimscript bridge accessible across modules
--

local api = vim.api
local cmd = vim.cmd

--
-- Creates a key mapping. This is a convenience for calling ':help nvim_set_keymap'.
-- Only global mappings can be set this way - buffer-local mappings use
-- ':help nvim_buf_set_keymap' instead since they need a reference to a specific
-- buffer.
--
-- The arguments are mostly the same as those of nvim_set_keymap, with some
-- conveniences thrown in.
--
-- modes - Which mapmode(s) should the mapping be set for. This can either
--         be a single string (e.g. 'n'), or a table to set multiple modes at once
--         (e.g. {'n', 'v', 'o'})
-- lhs - The keysequence to map. Keycodes (':help keycodes') are expanded as expected.
-- rhs - The resulting keysequence. Keycodes (':help keycodes') are expanded as expected.
-- opts - Any map arguments to include, except for <buffer>. See ':help map-arguments'
--
local function map(modes, lhs, rhs, opts)
    -- Options are, indeed, optional
    opts = opts or {}

    -- Default to a noremap mapping, since that's 99% of what I end up doing anyway.
    -- You can always pass { noremap = false } in the other 1%
    opts.noremap = opts.noremap == nil and true or opts.noremap

    -- Expand a single argument mode to a table
    if type(modes) == 'string' then
        modes = {modes}
    end

    -- Call the bridge function to create a mapping for each mode
    for _, mode in ipairs(modes) do
        api.nvim_set_keymap(mode, lhs, rhs, opts)
    end
end

--
-- Creates a key mapping. This is a convenience for calling ':help nvim_buf_set_keymap'.
--
-- The arguments are mostly the same as those of nvim_buf_set_keymap, with some
-- conveniences thrown in.
--
-- bufnum - Which buffer to add local mappings for
-- modes - Which mapmode(s) should the mapping be set for. This can either
--         be a single string (e.g. 'n'), or a table to set multiple modes at once
--         (e.g. {'n', 'v', 'o'})
-- lhs - The keysequence to map. Keycodes (':help keycodes') are expanded as expected.
-- rhs - The resulting keysequence. Keycodes (':help keycodes') are expanded as expected.
-- opts - Any map arguments to include, except for <buffer>. See ':help map-arguments'
--
local function bufmap(bufnum, modes, lhs, rhs, opts)
    -- Options are, indeed, optional
    opts = opts or {}

    -- Default to a noremap mapping, since that's 99% of what I end up doing anyway.
    -- You can always pass { noremap = false } in the other 1%
    opts.noremap = opts.noremap == nil and true or opts.noremap

    -- Expand a single argument mode to a table
    if type(modes) == 'string' then
        modes = {modes}
    end

    -- Call the bridge function to create a mapping for each mode
    for _, mode in ipairs(modes) do
        api.nvim_buf_set_keymap(bufnum, mode, lhs, rhs, opts)
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
    if clear then
        cmd([[autocmd!]])
    end

    -- Add each of the requested commands
    for _, command in ipairs(commands) do
        cmd('autocmd ' .. command)
    end

    -- Restore the default group for subsequent auto commands
    cmd([[augroup END]])
end

return { augroup = augroup, map = map, bufmap = bufmap }

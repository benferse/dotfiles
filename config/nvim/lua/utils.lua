--
-- Small utilities to make common configuration patterns with
-- the vimscript bridge accessible across modules
--

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
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    end
end

return { map = map }

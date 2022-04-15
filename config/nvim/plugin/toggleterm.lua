local is_ok, toggleterm = pcall(require, 'toggleterm')
if not is_ok then
    return
end

toggleterm.setup {
    open_mapping = [[<M-S-`>]],
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = false,
    persist_size = true,
    direction = 'float',
    size = function(term)
        if term.direction == 'horizontal' then
            return 15
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
        end
    end,
    close_on_exit = true,
    float_opts = {
        border = 'rounded',
    }
}

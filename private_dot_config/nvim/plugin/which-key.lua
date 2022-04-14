local is_ok, which_key = pcall(require, 'which-key')
if not is_ok then
    return
end

which_key.setup {
    window = {
        align = 'right',
        border = 'rounded',
        position = 'bottom',
        width = function() return math.floor(vim.o.columns * 0.4) end,
    },
    layout = {
        height = { min = 99 },
    },
    triggers = 'auto',
    triggers_blacklist = {
        i = { 'j', 'k' },
        v = { 'j', 'k' },
    },
}

vim.cmd [[
    highlight link FloatBorder Normal
    highlight link WhichKeyFloat Normal
]]

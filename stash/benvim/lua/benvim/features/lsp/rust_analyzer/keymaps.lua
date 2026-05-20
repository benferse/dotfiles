local M = {}

function M.on_attach(client, bufnr)
    -- rust-tools supports injecting additional actions into the hover window,
    -- so replace the standard hover keymap with the Rust one
    vim.keymap.set("n", "K", "<cmd>RustHoverActions<cr>", { buffer = bufnr })
end

return M

-- Plugins and modifications to the core text editing
-- experience, and isn't that really why we're here in
-- the first place?

local function setup()
    vim.cmd([[
        packadd nvim-autopairs
        packadd nvim-comment
    ]])

    require('nvim_comment').setup {
        marker_padding = true,
        comment_empty = true,
    }

    vim.opt.completeopt = 'menuone,noinsert,noselect'

    require('nvim-autopairs').setup {
        disable_filetype = { 'TelescopePrompt' },
    }

    local ap = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', ap.on_confirm_done({ map_char = { tex = '' }}))
end

return { setup = setup }

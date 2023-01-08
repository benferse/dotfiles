return {
    -- snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        config = {
            history = true,
            delete_check_events = "TextChanged",
        },
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true, remap = true, silent = true, mode = "i",
            },
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },
    -- automatic completion / cleanup of paired delimiters
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        config = function()
            require("mini.pairs").setup({})
        end,
    },
    -- completion / popup / omnifunc
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-emoji",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<cr>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "emoji" },
                }),
            })
        end,
    },
}

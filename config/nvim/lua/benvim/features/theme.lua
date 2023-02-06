return {
	{
		"arcticicestudio/nord-vim",
		lazy = false,
		priority = 1000,
		config = function()
            -- All bells and whistles :)
            vim.g.nord_bold = 1
            vim.g.nord_underline = 1
            vim.g.nord_italic = 1
            vim.g.nord_italic_comments = 1

            -- Use our preferred color scheme
			vim.cmd.colorscheme('nord')

            -- Highlight group modifications
            vim.cmd [[
                highlight link FloatBorder Normal
                highlight link NormalFloat Normal
            ]]
		end
	},
}

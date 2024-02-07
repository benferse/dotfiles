return {
  -- Nord color scheme
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
    end,
  },

  -- Configure LazyVim to load Nord
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}

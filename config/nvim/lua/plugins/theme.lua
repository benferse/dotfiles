return {
  -- Nord color scheme
  {
    "benferse/nordtheme-vim",
    dev = true,
    lazy = false,
    priority = 1000,
    config = function()
      -- All bells and whistles :)
      vim.g.nord_bold = 1
      vim.g.nord_underline = 1
      vim.g.nord_italic = 1
      vim.g.nord_italic_comments = 1
      vim.g.nord_cursor_line_number_background = 1
    end,
  },

  -- Configure LazyVim to load Nord
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },

  -- We don't need the giant logo on the splash screen
  {
    "nvimdev/dashboard-nvim",
    opts = function()
      local v = vim.version() or { major = 0, minor = 0, patch = 0 }
      local banner = "benvim v2024 / neovim " .. v.major .. "." .. v.minor .. "." .. v.patch
      return {
        config = {
          header = { banner },
        },
      }
    end,
  },

  -- I like edgy.nvim for the auto placement, but not so much all the
  -- other embellishments :)
  {
    "folke/edgy.nvim",
    opts = {
      left = {
        {
          title = "Explorer",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
        },
      },
      animate = {
        enabled = false,
      },
      wo = {
        winbar = false,
      },
    },
  },

  -- Use a border to get some differentiation for popup doc windows
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}

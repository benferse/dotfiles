return {
  {
    "mrcjkb/rustaceanvim",
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          float_win_config = {
            border = "rounded",
          },
        },
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      vim.list_extend(opts.adapters, {
        require("rustaceanvim.neotest"),
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    },
  },
}

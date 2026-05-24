-- Hacks, temporary workarounds, and other mumbo-jumbo
return {
  -- https://github.com/nvim-neotest/neotest/pull/337
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
  },
  -- https://github.com/nvim-neotest/neotest/pull/337
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/nvim-nio" },
  },
}

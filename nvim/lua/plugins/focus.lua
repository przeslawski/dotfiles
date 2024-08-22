return {
  {
    'nvim-focus/focus.nvim',
    version = false,
    keys = {
      { "<leader>fo", "<cmd>FocusToggle<cr>", desc = "Toggle Focus Mode" },
    },
    config =
        function()
          return require("focus").setup()
        end,
  },
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
}

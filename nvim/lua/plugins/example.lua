return {

  {
    "folke/noice.nvim",
    enabled = false,
  },

  {
    "rcarriga/nvim-notify",
    enabled = false,
  },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
}

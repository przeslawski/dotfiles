return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    opts = {
      ensure_installed = {
        "cmake",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "cmake-language-server"
      },
    },
  },
}

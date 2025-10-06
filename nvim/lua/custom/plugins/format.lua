return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
    {
      '<leader>uf',
      function()
        -- read buffer number and toggle vim.b.disable_autoformat for the buffer
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        vim.notify_once('Autoformat ' .. (vim.b.disable_autoformat and 'disabled' or 'enabled'))
      end,
      mode = '',
      desc = '[u]I Toggle [f]ormat buffer',
    },
    {
      '<leader>uF',
      function()
        -- read buffer number and toggle vim.b.disable_autoformat for the buffer
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify_once('Autoformat globally ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
      end,
      mode = '',
      desc = '[u]I Toggle [F]ormat [G]lobally',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end

      if vim.g.disable_autoformat or vim.b.disable_autoformat then
        return {}
      end

      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      cpp = { 'clang-format' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}

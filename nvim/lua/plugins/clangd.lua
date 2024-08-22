return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c", "cpp" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          keys = {
            { "<leader><S-Tab>", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("Makefile", "CMakeLists.txt", "build.ninja")(fname)
                or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname)
                or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = { offsetEncoding = { "utf-16" } },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    keys = {
      { "<leader>1", "<CMD>ClangdToggleInlayHints<CR>", desc = "Toggle Inlay Hints" },
    },
    config = function() end,
    opts = function(_, _)
      local opts2 = {
        extensions = {
          inlay_hints = {
            inline = vim.fn.has("nvim-0.10") == 1,
            -- Options other than `highlight' and `priority' only work
            -- if `inline' is disabled
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refresh of the inlay hints.
            -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = { "CursorHold" },
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
          },
          ast = {
            role_icons = {
              type = "",
              declaration = "",
              expression = "",
              specifier = "",
              statement = "",
              ["template argument"] = "",
            },

            kind_icons = {
              Compound = "",
              Recovery = "",
              TranslationUnit = "",
              PackExpansion = "",
              TemplateTypeParm = "",
              TemplateTemplateParm = "",
              TemplateParamObject = "",
            },

            highlights = {
              detail = "Comment",
            },
          },
        },
      }
      return opts2
    end,
  },
  {
    "nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
    end,
  },
}

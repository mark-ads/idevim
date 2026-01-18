return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    -- Mason setup
    require("mason-null-ls").setup({
      ensure_installed = {
        "stylua",
        "ruff",
      },
      automatic_installation = true,
    })

    local sources = {
      diagnostics.checkmake,
      formatting.prettier.with({ filetypes = { "html", "json", "yaml", "markdown" } }),
      formatting.stylua,
      formatting.shfmt.with({ args = { "-i", "4" } }),
      formatting.terraform_fmt,
      require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
      require("none-ls.formatting.ruff_format"),
    }

    null_ls.setup({
      sources = sources,
      -- on_attach теперь только для ручного вызова
      on_attach = function(client, bufnr)
        -- создаём маппинг для ручного форматирования
        if client.supports_method("textDocument/formatting") then
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end
      end,
    })
  end,
}

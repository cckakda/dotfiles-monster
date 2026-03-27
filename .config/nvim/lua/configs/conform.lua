local options = {
  formatters = {
    prettier = {
      prepend_args = { "--use-tabs", "--tab-width", "8" },
    },
    pint = {
      command = "pint",
      args = { "-" }, -- reads from stdin
      stdin = true,
    },
    php_cs_fixer = {
      command = "php-cs-fixer",
      args = { "fix", "--quiet", "--using-cache=no", "-" },
      stdin = true,
    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    vue = { "prettier" },
    php = { "pint" }, -- or "php_cs_fixer"
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options

require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "blade-formatter"}
vim.lsp.enable(servers)

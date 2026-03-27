require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
map("n", "<leader>w", "<cmd>:write<cr>")
map("n", "<leader>q", "<cmd>:quit<cr>")
map("n", "<leader>Q", "<cmd>:wqa<cr>")
-- map("n", "<Tab>", "x", { desc = "Delete one character" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Database management keybindings
map("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggle Database UI" })
map("n", "<leader>dc", "<cmd>DBCompletionClearCache<CR>", { desc = "Clear DB Cache" })
map("n", "<leader>da", "<cmd>DBUIAddConnection<CR>", { desc = "Add DB Connection" })
map("n", "<leader>df", "<cmd>DBUIFindBuffer<CR>", { desc = "Find DB Buffer" })

-- Copy file paths
map('n', '<leader>cf', ':let @+ = expand("%")<CR>', { desc = "Copy Relative Path" })
map('n', '<leader>cp', ':let @+ = expand("%:p")<CR>', { desc = "Copy Full Path" })
map('n', '<leader>ct', ':let @+ = expand("%:t")<CR>', { desc = "Copy Filename" })
-- LSP Navigation with Telescope
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Go to Definition" })
map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "Find References" })
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Go to Implementation" })
map("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Go to Type Definition" })

-- LSP actions
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>cF", vim.lsp.buf.format, { desc = "Format Code" })
map("n", "<leader>fm", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format File" })

-- Diagnostics navigation
map("n", "<leader>cs", "<cmd>Telescope diagnostics<cr>", { desc = "Search Diagnostics" })

-- Workspace symbols
map("n", "<leader>cw", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Workspace Symbols" })
map("n", "<leader>cW", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Dynamic Workspace Symbols" })

-- Markdown rendering
map("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle Markdown Render" })

-- Window resize
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Laravel keybindings
map("n", "<leader>la", "<cmd>Artisan<cr>", { desc = "Artisan" })
map("n", "<leader>lm", "<cmd>LaravelMake<cr>", { desc = "Laravel Make" })
map("n", "<leader>lr", "<cmd>LaravelRoute<cr>", { desc = "Laravel Routes" })
map("n", "<leader>lg", "<cmd>LaravelGoto<cr>", { desc = "Laravel Goto" })
map("n", "<leader>ls", "<cmd>LaravelStatus<cr>", { desc = "Laravel Status" })

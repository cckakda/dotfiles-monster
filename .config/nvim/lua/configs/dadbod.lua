-- Database configuration for vim-dadbod
local M = {}

-- Database UI configuration
M.db_ui = {
  use_nerd_fonts = 1,
  winwidth = 30,
  winposition = "right",
  show_help = 1,
  show_database_icon = 1,
  icons = {
    expanded = "▾",
    collapsed = "▸",
    saved_query = "💾",
    new_query = "⭐",
    tables = "📋",
    buffers = "🗎",
    connection = "🔌",
    bookmarks = "🔖",
  },
  -- Save queries to a file
  save_location = "~/.local/share/db_ui",
  -- Show database type in connection list
  show_database_icon = 1,
  -- Use floating window for query results
  use_float = 1,
  -- Float window configuration
  float = {
    border = "rounded",
    max_width = 120,
    max_height = 40,
  },
}

-- Database completion configuration
M.completion = {
  mark = "[DB]",
  -- Enable for specific file types
  filetypes = { "sql", "mysql", "plsql" },
}

-- Database connection examples
M.connections = {
  -- Example PostgreSQL connection
  -- postgres = "postgresql://username:password@localhost:5432/database_name",
  
  -- Example MySQL connection
  -- mysql = "mysql://username:password@localhost:3306/database_name",
  
  -- Example SQLite connection
  -- sqlite = "sqlite:///path/to/database.db",
  
  -- Example SQL Server connection
  -- mssql = "sqlserver://username:password@localhost:1433/database_name",
}

-- Setup function
function M.setup()
  -- Set global variables for db_ui
  for key, value in pairs(M.db_ui) do
    vim.g["db_ui_" .. key] = value
  end
  
  -- Set completion mark
  vim.g.vim_dadbod_completion_mark = M.completion.mark
  
  -- Set up filetype-specific configurations
  vim.api.nvim_create_autocmd("FileType", {
    pattern = M.completion.filetypes,
    callback = function()
      -- Set omnifunc for built-in completion
      vim.bo.omnifunc = "vim_dadbod_completion#omni"
      
      -- Configure nvim-cmp if available
      local has_cmp, cmp = pcall(require, "cmp")
      if has_cmp then
        cmp.setup.buffer({
          sources = {
            { name = "vim-dadbod-completion" },
            { name = "buffer" },
          },
        })
      end
    end,
  })
end

return M 
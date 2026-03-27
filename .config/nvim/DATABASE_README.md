# Database Management with vim-dadbod in NvChad

This configuration adds comprehensive database management capabilities to your NvChad setup using vim-dadbod, vim-dadbod-ui, and vim-dadbod-completion.

## Features

- **Database UI**: Visual interface for managing database connections and executing queries
- **Auto-completion**: Intelligent completion for SQL tables, columns, and syntax
- **Multiple Database Support**: PostgreSQL, MySQL, SQLite, SQL Server, Oracle, and more
- **Query Management**: Save, load, and organize your SQL queries
- **Floating Windows**: Modern UI with floating windows for query results

## Keybindings

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>db` | `DBUIToggle` | Toggle Database UI |
| `<leader>dc` | `DBCompletionClearCache` | Clear database completion cache |
| `<leader>da` | `DBUIAddConnection` | Add new database connection |
| `<leader>df` | `DBUIFindBuffer` | Find database buffer |

## Commands

| Command | Description |
|---------|-------------|
| `DBUI` | Open Database UI |
| `DBUIToggle` | Toggle Database UI |
| `DBUIAddConnection` | Add new database connection |
| `DBUIFindBuffer` | Find database buffer |
| `DBCompletionClearCache` | Clear completion cache |

## Setting Up Database Connections

### Method 1: Using DBUI (Recommended)
1. Press `<leader>db` to open the Database UI
2. Press `a` to add a new connection
3. Enter your connection details

### Method 2: Environment Variables
Set the `$DATABASE_URL` environment variable:
```bash
export DATABASE_URL="postgresql://username:password@localhost:5432/database_name"
```

### Method 3: Vim Variables
Set connection in your vimrc or in a buffer:
```vim
" Global connection
let g:db = 'postgresql://username:password@localhost:5432/database_name'

" Buffer-specific connection
let b:db = 'mysql://username:password@localhost:3306/database_name'

" Table-specific (for column completion)
let b:db_table = 'table_name'
```

## Connection String Formats

### PostgreSQL
```
postgresql://username:password@localhost:5432/database_name
```

### MySQL
```
mysql://username:password@localhost:3306/database_name
```

### SQLite
```
sqlite:///path/to/database.db
```

### SQL Server
```
sqlserver://username:password@localhost:1433/database_name
```

## Using the Database UI

1. **Open UI**: `<leader>db`
2. **Add Connection**: Press `a`
3. **Browse Tables**: Navigate through your database structure
4. **Execute Queries**: Press `e` on any table or write custom queries
5. **Save Queries**: Press `s` to save frequently used queries
6. **Load Queries**: Press `l` to load saved queries

## Auto-completion

The plugin automatically provides completion for:
- Table names
- Column names (context-aware)
- SQL keywords
- Aliases and table references

Completion works in SQL files and is marked with `[DB]` for easy identification.

## Configuration

Database settings are configured in `lua/configs/dadbod.lua`. You can customize:

- UI appearance and icons
- Window positioning and sizing
- Completion behavior
- Float window settings

## Troubleshooting

### Clear Cache
If you experience stale completion data:
```vim
:DBCompletionClearCache
```

### Check Connection
Verify your connection string format and credentials.

### File Type Detection
Ensure your SQL files have the correct file type:
- `.sql` files
- Files with `sql`, `mysql`, or `plsql` file types

## Dependencies

- `tpope/vim-dadbod` - Core database functionality
- `kristijanhusak/vim-dadbod-ui` - User interface
- `kristijanhusak/vim-dadbod-completion` - Auto-completion

## Additional Resources

- [vim-dadbod](https://github.com/tpope/vim-dadbod) - Core plugin
- [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui) - UI plugin
- [vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion) - Completion plugin

## Example Workflow

1. Open Database UI: `<leader>db`
2. Add your database connection
3. Browse tables and structure
4. Write SQL queries with auto-completion
5. Execute queries and view results
6. Save useful queries for later use

Enjoy your enhanced database management experience in NvChad! 
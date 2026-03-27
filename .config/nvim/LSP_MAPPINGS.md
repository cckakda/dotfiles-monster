# LSP Navigation Mappings Reference

This document lists all LSP (Language Server Protocol) navigation and action mappings in your NvChad configuration.

## 🚀 Core Navigation

### Go to Definitions & References
| Key | Command | Description |
|-----|---------|-------------|
| `gd` | `Telescope lsp_definitions` | Go to definition(s) in fuzzy finder |
| `gD` | `vim.lsp.buf.declaration` | Go to declaration |
| `gr` | `Telescope lsp_references` | **Find all references** (what you asked for!) |
| `gi` | `Telescope lsp_implementations` | Go to implementation(s) |
| `gt` | `Telescope lsp_type_definitions` | Go to type definition(s) |

## 🔍 Telescope LSP Pickers

### Symbols & References
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>cw` | `Telescope lsp_workspace_symbols` | Search workspace symbols |
| `<leader>cW` | `Telescope lsp_dynamic_workspace_symbols` | Dynamic workspace symbols |

### Diagnostics
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>cs` | `Telescope diagnostics` | Browse all diagnostics |

## 🛠️ LSP Actions

### Code Operations
| Key | Mode | Command | Description |
|-----|------|---------|-------------|
| `K` | Normal | `vim.lsp.buf.hover` | Show hover documentation |
| `<leader>ca` | Normal/Visual | `vim.lsp.buf.code_action` | Apply code action |
| `<leader>cr` | Normal | `vim.lsp.buf.rename` | Rename symbol |
| `<leader>cd` | Normal | `vim.diagnostic.open_float` | Show line diagnostics |
| `<leader>cF` | Normal | `vim.lsp.buf.format` | Format code |

## 🩺 Diagnostics Navigation

### Quick Navigation
| Key | Command | Description |
|-----|---------|-------------|
| `]d` | `vim.diagnostic.goto_next` | Go to next diagnostic |
| `[d` | `vim.diagnostic.goto_prev` | Go to previous diagnostic |

## 📋 File Path Operations

### Copy Path Mappings
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>cf` | Copy relative path | Copy file path relative to cwd |
| `<leader>cp` | Copy full path | Copy absolute file path |
| `<leader>ct` | Copy filename | Copy just the filename |

## 🎯 Common Workflows

### Finding Where a Function is Used
1. Position cursor on function name
2. Press `gr` to open Telescope with all references
3. Select the reference you want to jump to

### Refactoring
1. Position cursor on symbol to rename
2. Press `<leader>cr` to rename
3. Type new name and confirm

### Understanding Code
1. Press `K` to see hover documentation
2. Press `gd` to jump to definition
3. Press `gr` to see all usages
4. Press `gt` to see type definition

### Code Fixes
1. Navigate to line with warning/error
2. Press `<leader>ca` to see available code actions
3. Select fix from the menu

## 🔧 How It Works

All LSP navigation uses **Telescope** for fuzzy finding, giving you a clean interface to:
- Jump to definitions with preview
- Find all references across your codebase
- Browse implementations
- Search symbols
- View diagnostics

The fuzzy finder shows context and allows you to:
- Use arrow keys or `<C-n>`/`<C-p>` to navigate
- Press `<CR>` to jump to selection
- Type to filter results
- Press `<Esc>` to cancel

## 💡 Tips

1. **Finding References (`gr`)**: The most powerful feature - shows all places where a symbol is used
2. **Multiple Definitions**: Some languages allow multiple definitions (overloading). Telescope lets you pick
3. **Preview**: Telescope shows previews so you can see context before jumping
4. **Workspace-wide**: References search across the entire workspace, not just the current file

Enjoy your enhanced LSP navigation! 🎉


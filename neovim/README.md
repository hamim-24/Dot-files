# Neovim Configuration

This repository contains my modern Neovim configuration files, providing a feature-rich IDE-like experience with both Lua (`init.lua`) and Vim script (`init.vim`) configurations. The setup includes comprehensive language support, modern UI elements, and intelligent code completion.

## Features

### Core Features
- Modern plugin management with [lazy.nvim](https://github.com/folke/lazy.nvim) (Lua) and [vim-plug](https://github.com/junegunn/vim-plug) (Vim)
- VSCode-like appearance with dark theme and semantic highlighting
- Full LSP (Language Server Protocol) support
- Treesitter-based syntax highlighting
- Intelligent code completion
- File explorer with icons
- Status line with useful information
- Rainbow parentheses for better code readability

### Language Support
Built-in support for multiple languages including:
- Lua
- Python
- JavaScript/TypeScript
- HTML/CSS
- Bash
- And more via LSP servers

### UI Features
- VSCode-inspired dark theme
- Modern status line with `lualine`
- File tree explorer with `nvim-tree`
- Semantic highlighting for better code understanding
- Line numbers (absolute and relative options)
- Mouse support
- True color support
- System clipboard integration

### Code Intelligence
- LSP features:
  - Go to definition (`gd`)
  - Hover documentation (`K`)
  - Find references (`gr`)
  - Go to implementation (`gi`)
  - Rename symbol (`<leader>rn`)
- Autocompletion via `nvim-cmp` (Lua) or `coc.nvim` (Vim)
- Treesitter for advanced syntax highlighting
- Rainbow parentheses for nested structures
- Auto-formatting on save

### Key Features by Configuration

#### Lua Configuration (`init.lua`)
- Modern plugin management with lazy.nvim
- Native LSP configuration
- Treesitter integration
- Advanced completion with nvim-cmp
- VSCode-like semantic token colors
- Mason for easy LSP server installation

#### Vim Configuration (`init.vim`)
- Traditional plugin management with vim-plug
- CoC for code completion
- OneDark theme
- Simpler setup with familiar Vim configurations
- Persistent undo history
- Custom key mappings

## Installation

1. Clone this repository:
```bash
# First create the necessary directories
mkdir -p ~/.config/nvim

# Clone the repository
git clone https://github.com/hamim-24/Dot-files.git

# Copy Neovim configuration files to the correct location
cp -r Dot-files/neovim/init.lua ~/.config/nvim/
cp -r Dot-files/neovim/init.vim ~/.config/nvim/    # If you want to use the Vim script version, it is the backdated
```

2. Install the required dependencies:
- Neovim (>= 0.8.0)
- Git
- A Nerd Font (for icons)
- Node.js (for LSP features)

3. For Lua configuration:
- The configuration will automatically install lazy.nvim
- Launch Neovim and wait for the plugins to install

4. For Vim configuration:
- Install vim-plug
- Launch Neovim and run `:PlugInstall`

## Key Bindings and Shortcuts Guide

### General Navigation

#### File Navigation
- `,` - Leader key (used for custom commands)
- `Ctrl + n` - Toggle file explorer (NvimTree)
- `<leader>y` - Yank (copy) to system clipboard

#### LSP Navigation
- `gd` - **Go to Definition**: Jump to where a symbol is defined
- `gr` - **Find References**: Show all references of the symbol under cursor
- `gi` - **Go to Implementation**: Jump to implementation of interface/abstract class
- `K` - **Hover Documentation**: Show documentation for symbol under cursor
- `<leader>rn` - **Rename Symbol**: Rename a symbol across the entire workspace

### Code Completion and Editing

#### Autocompletion Controls
- `Ctrl + Space` - Trigger completion menu manually
- `Enter` - Confirm/Accept selected completion
- `Tab` - Navigate to next completion item
- `Shift + Tab` - Navigate to previous completion item

#### Popup Menu Navigation
- `Space` - Close completion menu and insert space
- `Up/Down` - Navigate through completion items
- `Left/Right` - Close completion menu and move cursor

### Window Management

#### Split Windows
- `Ctrl + w + v` - Split window vertically
- `Ctrl + w + s` - Split window horizontally
- `Ctrl + w + h/j/k/l` - Navigate between splits
- `Ctrl + w + q` - Close current split

#### Window Resizing
- `Ctrl + w + >` - Increase window width
- `Ctrl + w + <` - Decrease window width
- `Ctrl + w + +` - Increase window height
- `Ctrl + w + -` - Decrease window height
- `Ctrl + w + =` - Equal window sizes

### File Operations

#### File Explorer (NvimTree)
When in file explorer:
- `a` - Add new file/directory
- `d` - Delete file/directory
- `r` - Rename file/directory
- `x` - Cut file/directory
- `c` - Copy file/directory
- `p` - Paste file/directory
- `R` - Refresh file explorer

#### Search and Replace
- `/` - Search forward
- `?` - Search backward
- `n` - Next search result
- `N` - Previous search result
- `:%s/old/new/g` - Replace all occurrences
- `:%s/old/new/gc` - Replace all occurrences with confirmation

### Code Actions and Formatting

#### Auto-formatting
The following file types will auto-format on save:
- Python (*.py)
- C/C++ (*.c, *.cpp)
- JavaScript/TypeScript (*.js, *.ts)
- HTML (*.html)
- CSS (*.css)
- JSON (*.json)
- Shell scripts (*.sh)

#### Code Folding
- `za` - Toggle fold under cursor
- `zR` - Open all folds
- `zM` - Close all folds
- `zo` - Open fold under cursor
- `zc` - Close fold under cursor

## Customization

Both configurations are well-documented and modular. You can customize them by:

1. Modifying theme settings in the UI section
2. Adding/removing language servers in the LSP configuration
3. Adjusting Treesitter settings for syntax highlighting
4. Modifying key bindings to match your preferences

## Updating

### Lua Configuration
- Plugins will be updated automatically by lazy.nvim
- LSP servers can be updated through Mason

### Vim Configuration
- Update plugins with `:PlugUpdate`
- Update CoC extensions with `:CocUpdate`
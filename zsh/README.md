# Zsh Configuration

This is a feature-rich Zsh configuration using Oh My Zsh with Powerlevel10k theme and various productivity-enhancing plugins. The setup includes custom functions, aliases, and environment configurations optimized for development work.

## Features

### Core Components
- **Oh My Zsh** framework for managing Zsh configuration
- **Powerlevel10k** theme for a beautiful and informative prompt
- **Custom functions** for enhanced navigation and development workflows
- **Development environment** configurations for Java, Python, and LLVM

### Installed Plugins
1. **git** - Git integration and aliases
2. **zsh-syntax-highlighting** - Command syntax highlighting
3. **zsh-autosuggestions** - Fish-like autosuggestions
4. **fzf** - Fuzzy finder integration
5. **z** - Quick directory jumping
6. **extract** - Smart archive extraction
7. **web-search** - Quick web searches from terminal

### Custom Functions

#### Directory Navigation (cddir)
```bash
cddir [base_directory]
```
An enhanced directory navigation function that uses `fzf` for interactive directory selection:
- Defaults to `$HOME` if no base directory is provided
- Fuzzy search through directories
- Visual directory picker
- Error handling for invalid directories

#### Java File Runner (runjava)
```bash
runjava <folder>
```
A smart Java development helper that:
- Finds Java files in specified folder
- Uses `fzf` for file selection
- Compiles and runs Java programs in one command
- Includes error handling

### Custom Aliases
```bash
openWithNvim
```
Opens files using Neovim with:
- Fuzzy file search
- File preview using `bat`
- Multiple file selection support

### Key Bindings
- **Tab** - Complete commands normally
- **Right Arrow** - Move cursor forward
- **Left Arrow** - Accept autosuggestion

## Environment Configurations

### Java Development
```bash
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
```

### Python Development
```bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
```

### LLVM
```bash
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
```

## Installation

1. Install Oh My Zsh:
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Install Powerlevel10k:
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

3. Install required plugins:
```bash
# Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install fzf
brew install fzf
$(brew --prefix)/opt/fzf/install
```

4. Copy the `.zshrc` file:
```bash
cp .zshrc ~/.zshrc
```

5. Install additional dependencies:
```bash
# Install bat for file preview
brew install bat

# Install required development tools
brew install pyenv
brew install openjdk
brew install llvm
```

## Usage Tips

### Directory Navigation
```bash
# Navigate from home directory
cddir

# Navigate from specific directory
cddir ~/Projects
```

### File Opening
```bash
# Open files with Neovim using fuzzy search
openWithNvim
```

### Java Development
```bash
# Compile and run Java files in a directory
runjava ./my-java-project
```

## Customization

### Adding New Plugins
1. Add plugin name to the plugins array in `.zshrc`:
```bash
plugins=(
  existing-plugins
  new-plugin
)
```

### Modifying Theme
- Run `p10k configure` to customize Powerlevel10k theme
- Edit `~/.p10k.zsh` for manual customization

### Adding Custom Functions
Add new functions to `.zshrc`:
```bash
my_function() {
  # Your code here
}
```

## Troubleshooting

### Common Issues

1. **Powerlevel10k fonts not loading**
   - Install recommended fonts:
   ```bash
   brew tap homebrew/cask-fonts
   brew install --cask font-hack-nerd-font
   ```

2. **Autosuggestions not working**
   - Verify plugin installation
   - Check key bindings in `.zshrc`

3. **Java/Python paths not working**
   - Verify installations
   - Check environment variables
   - Restart terminal session

## Maintenance

### Updating
```bash
# Update Oh My Zsh
omz update

# Update plugins
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting pull
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions pull
```

### Adding New Environment Variables
Add to `.zshrc`:
```bash
export NEW_VAR="value"
export PATH="$NEW_VAR/bin:$PATH"
```
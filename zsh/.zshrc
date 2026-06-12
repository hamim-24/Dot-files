# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Lazy-load cddir function to save startup time
# cddir() {
#     local base_dir="${1:-$HOME}"  # Default to ~ if no input
#     base_dir="${base_dir/#\~/$HOME}"  # Expand ~

#     # Check if the base dir exists
#     if [[ ! -d "$base_dir" ]]; then
#         echo "❌ '$base_dir' is not a valid directory"
#         return 1
#     fi

#     # Use fzf to search for subdirectories
#     local dir
#     dir=$(find "$base_dir" -type d 2>/dev/null | fzf --prompt="📁 Pick a folder: ")

#     # If a directory was selected, cd into it
#     if [[ -n "$dir" ]]; then
#         cd "$dir" || echo "❌ Failed to cd into $dir"
#     else
#         echo "⚠️ Cancelled"
#     fi
# }

# Optional: disable compfix warning (do this early)
ZSH_DISABLE_COMPFIX=true

# Plugins (DO NOT include zsh-autosuggestions here)
# Removed: fzf (heavy), web-search (unused) for faster startup
plugins=(
  git
  zsh-syntax-highlighting
  z
  extract
)

# Load Oh My Zsh (must come BEFORE binding keys)
source $ZSH/oh-my-zsh.sh

# Manually source autosuggestions (after Oh My Zsh)
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh



# search a file with preview and open with nvim 
alias openWithNvim='nvim $(fzf -m --preview="bat --color=always {}")'
alias ls='ls -p --color=auto'
alias la='eza -la'
alias cat='bat'
alias c='clear'
alias py='python'

EDITOR='nvim'

# Enable help command in zsh
autoload -Uz run-help
alias help=run-help

# Make TAB accept autosuggestions
# Restore default Right Arrow behavior
bindkey '^[[C' forward-char

# Make Left Arrow accept the suggestion
bindkey '^[[D' autosuggest-accept

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# runjava() {
#   if [ -z "$1" ]; then
#     echo "Usage: runjava <folder>"
#     return 1
#   fi

#   folder="$1"
#   file=$(find "$folder" -name "*.java" | fzf)

#   if [ -z "$file" ]; then
#     echo "No file selected."
#     return 1
#   fi

#   class=$(basename "$file" .java)
#   javac "$folder"/*.java && java -cp "$folder" "$class"
# }

# Lazy-load Java only when needed
alias usejava='export JAVA_HOME=$(/usr/libexec/java_home -v 25); export PATH="$JAVA_HOME/bin:$PATH"; echo "Java environment loaded"'

# Keep other paths (needed for tools)
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# Disabled automatic pyenv init to stop per-shell auto-activation of Python

# enable 24-bit color in terminal
export TERM=xterm-256color
export COLORTERM=truecolor
export PATH="/opt/homebrew/bin:$PATH"

# Lazy-load CPLEX only when needed
alias usecplex='export CPLEX_HOME=/Users/Inz_mac/Applications/CPLEX_Studio_Community2212/cplex; export DYLD_LIBRARY_PATH=$CPLEX_HOME/lib/arm64_osx/static_pic:$DYLD_LIBRARY_PATH; export PATH=$CPLEX_HOME/bin:$PATH; echo "CPLEX environment loaded"'


# Added by Antigravity
export PATH="/Users/Inz_mac/.antigravity/antigravity/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/Inz_mac/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/Inz_mac/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/Inz_mac/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/Inz_mac/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Lazy-load conda function
conda() {
    __conda_setup="$('/Users/Inz_mac/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/Inz_mac/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/Inz_mac/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/Inz_mac/miniconda3/bin:$PATH"
        fi
    fi
    command conda "$@"
}

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:/opt/homebrew/bin:$PATH"
export PATH="$HOME/bin:/opt/homebrew/bin:$PATH"

# ESP compile and upload function
esp_upload() {
    local port="${1:-/dev/tty.usbmodem1234561}"
    local board="${2:-esp32:esp32:esp32s3}"
    local baud="${3:-115200}"
    local sketch_dir="${4:-.}"
    
    echo "📦 Compiling sketch..."
    
    # If using Arduino CLI
    if command -v arduino-cli &> /dev/null; then
        arduino-cli compile -b "$board" "$sketch_dir" || { echo "❌ Compilation failed"; return 1; }
        echo "✅ Compilation successful"
        echo "📤 Uploading to $port..."
        arduino-cli upload -p "$port" -b "$board" "$sketch_dir" || { echo "❌ Upload failed"; return 1; }
        echo "✅ Upload complete!"
    
    # If using PlatformIO
    elif command -v pio &> /dev/null; then
        pio run -d "$sketch_dir" || { echo "❌ Compilation failed"; return 1; }
        echo "✅ Compilation successful"
        echo "📤 Uploading to $port..."
        pio run -d "$sketch_dir" -t upload --upload-port "$port" || { echo "❌ Upload failed"; return 1; }
        echo "✅ Upload complete!"
    
    else
        echo "❌ Neither arduino-cli nor PlatformIO found"
        echo "Install one of them first"
        return 1
    fi
}

# Quick port scanner
esp_ports() {
    echo "Available ESP ports:"
    ls /dev/cu.* 2>/dev/null | grep -E "usb|serial" || echo "No ESP ports found"
}

# Monitor serial output
esp_monitor() {
    local port="${0:-/dev/cu.usbserial-0001}"
    local baud="${2:-115200}"
    
    if command -v pio &> /dev/null; then
        pio device monitor -p "$port" -b "$baud"
    else
        echo "Using screen (press Ctrl+A then Q to exit)"
        screen "$port" "$baud"
    fi
}

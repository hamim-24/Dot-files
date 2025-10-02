# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# it can not search the file outside that directory
#cddir() {
#  cd "$(find . -type d | fzf)"
#}

# it can search the file outside the directory
cddir() {
    local base_dir="${1:-$HOME}"  # Default to ~ if no input
    base_dir="${base_dir/#\~/$HOME}"  # Expand ~

    # Check if the base dir exists
    if [[ ! -d "$base_dir" ]]; then
        echo "❌ '$base_dir' is not a valid directory"
        return 1
    fi

    # Use fzf to search for subdirectories
    local dir
    dir=$(find "$base_dir" -type d 2>/dev/null | fzf --prompt="📁 Pick a folder: ")

    # If a directory was selected, cd into it
    if [[ -n "$dir" ]]; then
        cd "$dir" || echo "❌ Failed to cd into $dir"
    else
        echo "⚠️ Cancelled"
    fi
}

# search a file with preview and open with nvim 
alias openWithNvim='nvim $(fzf -m --preview="bat --color=always {}")'

EDITOR='nvim'


# Oh My Zsh base
export ZSH="$HOME/.oh-my-zsh"

# Optional: disable compfix warning (do this early)
ZSH_DISABLE_COMPFIX=true

# Plugins (DO NOT include zsh-autosuggestions here)
plugins=(
  git
  zsh-syntax-highlighting
  fzf
  z
  extract
)

# Load Oh My Zsh (must come BEFORE binding keys)
source $ZSH/oh-my-zsh.sh

# Manually source autosuggestions (after Oh My Zsh)
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Make TAB accept autosuggestions
# Restore default Right Arrow behavior
bindkey '^[[C' forward-char

# Make Left Arrow accept the suggestion
bindkey '^[[D' autosuggest-accept
# User configuration

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

runjava() {
  if [ -z "$1" ]; then
    echo "Usage: runjava <folder>"
    return 1
  fi

  folder="$1"
  file=$(find "$folder" -name "*.java" | fzf)

  if [ -z "$file" ]; then
    echo "No file selected."
    return 1
  fi

  class=$(basename "$file" .java)
  # dir=$(dirname "$file")

  javac "$folder"/*.java && java -cp "$folder" "$class"
}


export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export JAVA_HOME=/opt/homebrew/Cellar/openjdk/25

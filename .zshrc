# .ZSHRC

# Variables
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="bat"
export BAT_THEME="Coldark-Dark"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERMINAL="alacritty"
export BROWSER="firefox-nightly"
export SCRIPT_PATH="$HOME/Code/scripts"
export STARSHIP_CONFIG="$HOME/dotfiles/.starship.toml"
export GOPATH="$HOME/go"
export PNPM_HOME="$HOME/Library/pnpm"
export PYTORCH_ENABLE_MPS_FALLBACK=1
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0
export OLLAMA_MODEL='codestral'
export FAST_OLLAMA_MODEL='llama3.1'
export WRITING_OLLAMA_MODEL='gemma2:27b'
export LS_COLORS="di=38;5;130:ln=36:so=32:pi=33:ex=31:bd=35:cd=34:su=31:sg=36:tw=32:ow=33"

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Set PATH
typeset -U path
path=(
  /opt/homebrew/bin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  $PNPM_HOME
  $HOME/.nvm/versions/node/v21.6.0/bin
  /Library/Frameworks/Python.framework/Versions/3.11/bin
  /usr/local/go/bin
  $HOME/.cargo/bin
  $HOME/.local/bin
  $GOPATH/bin
  $HOME/Library/Python/3.11/bin
  /usr/local/llamafile/bin
  $HOME/llamafile/bin
  $SCRIPT_PATH
  $PYENV_ROOT/bin
  $path
)

# Load colors
autoload -U colors && colors

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.cache/zsh/history"

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)  # Include hidden files.

# Load custom functions
source ~/.zsh/functions.zsh

# Load custom aliases
source ~/.zsh/aliases.zsh

# Load custom secrets
source ~/.zsh/secrets.zsh

# Load Atuin
eval "$(atuin init zsh)"

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load Cargo
. "$HOME/.cargo/env"

# Load Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load Starship prompt
eval "$(starship init zsh)"

# Load zoxide
eval "$(zoxide init zsh)"

# Load zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-syntax-highlighting (should be last)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

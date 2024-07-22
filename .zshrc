# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	poetry
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# pnpm
export PNPM_HOME="/Users/mike/Library/pnpm"
# pnpm end

######### Go #######
export GOPATH=/Users/mike/go


#### Custom Functions
# mkdir + cd
mkcd() { mkdir -p "$@" && cd "$_"; }

###### Git
# git clone a repo and cd into it
gccd() {
    git clone $1
    cd $(echo $1 | grep -oE '([^/]+)\.git$' | sed 's/\.git$//')
}

alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias glo='git log --oneline --decorate --color'


# NVM
lazy_load_nvm(){
    export NVM_DIR="$HOME/.nvm"
      [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
      [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}
nvm(){
    lazy_load_nvm
    nvm "$@"
}

# Atuin history
eval "$(atuin init zsh)"
export PAGER="bat"
export BAT_THEME="Coldark-Dark"


export LS_COLORS="di=38;5;130:ln=36:so=32:pi=33:ex=31:bd=35:cd=34:su=31:sg=36:tw=32:ow=33"

###### PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/mike/Library/pnpm:/Users/mike/.nvm/versions/node/v21.6.0/bin:/Library/Frameworks/Python.framework/Versions/3.11/bin:/usr/local/go/bin:/Users/mike/.cargo/bin:/Users/mike/.local/bin:/Users/mike/go/bin:/Users/mike/Library/Python/3.11/bin:/usr/local/llamafile/bin:$PATH"

export SCRIPT_PATH="/Users/mike/Code/scripts"
export PATH="$SCRIPT_PATH:$PATH"

###### Aliases
alias cat="bat"
alias ls="eza"
alias ll="ls -la"
alias python="python3"
alias pmpip="python -m pip"
alias code="cursor"
alias obsidian_backup="obsidian_backup.sh"
alias rezsh="source ~/.zshrc"

###### Secrets
# Using Bitwarden Secret Manager CLI 
# Usage: bws [option] <command>

# File to store the encrypted BWS access token
BWS_TOKEN_FILE="$HOME/.bws_token.enc"

# Function to securely set the BWS access token
bws_set_token() {
    echo -n "Enter your BWS access token: "
    read -s token
    echo  # New line after hidden input
    echo -n "$token" | openssl pkeyutl -encrypt -pubin -inkey ~/.ssh/bws_token_key.pub.pem -out "$BWS_TOKEN_FILE"
    if [ $? -eq 0 ]; then
        echo "BWS token encrypted and stored securely."
    else
        echo "Failed to encrypt the BWS token. Please try again."
        rm -f "$BWS_TOKEN_FILE"  # Remove the file if encryption failed
    fi
}

# Function to retrieve the BWS access token securely
bws_get_token() {
    if [ ! -f "$BWS_TOKEN_FILE" ]; then
        echo "BWS token not found. Please set it using bws_set_token" >&2
        return 1
    fi
    if [ ! -f ~/.ssh/bws_token_key ]; then
        echo "Private key not found at ~/.ssh/bws_token_key" >&2
        return 1
    fi
    openssl pkeyutl -decrypt -inkey ~/.ssh/bws_token_key -in "$BWS_TOKEN_FILE"
}

# Function to ensure BWS access token is set
bws_ensure_token() {
    if [ -z "$BWS_ACCESS_TOKEN" ]; then
        export BWS_ACCESS_TOKEN=$(bws_get_token)
        if [ $? -ne 0 ]; then
            echo "Failed to retrieve BWS access token. Please set it using bws_set_token" >&2
            return 1
        fi
    fi
}

# Stores an API key as a new secret
# Usage: store_api_key <KEY> <VALUE>
store_api_key() {
    bws_ensure_token || { echo "Unable to create secret. BWS access token is not set. Use bws_set_token to set it."; return 1; }

    local key="$1"
    local value="$2"
    local project_name="apikey"

    # Get the project ID
    local project_id=$(bws project list | jq -r '.[] | select(.name == "'$project_name'") | .id')

    if [ -z "$project_id" ]; then
        echo "Error: Project '$project_name' not found. Please create this project in Bitwarden Secrets Manager." >&2
        return 1
    fi

    # Create the secret
    bws secret create "$key" "$value" "$project_id"
    echo "Secret '$key' created successfully"

    # Reload secret into environment variables
    load_api_keys
}
alias newapikey='store_api_key'

# Loads API keys into environment variables
load_api_keys() {
    bws_ensure_token || { echo "Unable to load secrets. BWS access token is not set. Use bws_set_token to set it."; return 1; }

    local project_name="apikey"
    local project_id=$(bws project list | jq -r '.[] | select(.name == "'$project_name'") | .id')

    if [ -z "$project_id" ]; then
        echo "Error: Project '$project_name' not found. Please create this project in Bitwarden Secrets Manager." >&2
        return 1
    fi

    while IFS= read -r secret; do
        key=$(echo "$secret" | jq -r '.key')
        value=$(echo "$secret" | jq -r '.value')
        export "$key"="$value"
    done < <(bws secret list "$project_id" | jq -c '.[]')

    echo "All secrets from project '$project_name' have been loaded as environment variables."
}

# Ensure BWS token is set and load secrets when starting a new shell session
bws_ensure_token && load_api_keys|| echo "Failed to load API keys. Please check your bws setup and token."

###### FZF
source <(fzf --zsh)

# Fuzzy search for subdirectories with fcd
fzf_cd() {
    local dir
    dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
alias fcd='fzf_cd'

# Fuzzy search for processes to kill
fkill() {
  local pid
  pid=$(ps -ax -o pid,ppid,%cpu,%mem,command | sed 1d | sort -rnk4 | fzf --reverse --header="PID   PPID   %CPU  %MEM COMMAND" | awk '{print $1}')
  if [ "x$pid" != "x" ]; then
    echo "Killing process $pid"
    kill -9 "$pid"
  fi
}


###### AI

export OLLAMA_MODEL='codestral'

# Ask the AI for a CLI command with 'ai'
cli_ai() {
  setopt local_options no_glob
  python "$SCRIPT_PATH/cli_ai.py" "$@"
}

alias ai='noglob cli_ai'

# Have AI generate a git commit message with 'aicommit'
aicommit() {
  ai_git_commit.py
}

###### Video Helpers
# Generate subtitles for a video. Provide path to video as argument
# Usage: generate_subtitles /path/to/video.mp4
alias generate_subtitles='generate_subtitles.py'
# Generate thumbnail for a video
# Usage: generate_thumbnail /path/to/video.mp4
alias generate_thumbnail='generate_thumbnail.py'

###### Open Interpreter
# Get the latest version of OI from git
get_latest_oi() {
pip install --upgrade --force-reinstall git+https://github.com/OpenInterpreter/open-interpreter.git
}

# Sync my fork with the main repo
sync_oi() {
  sync_oi.py
}


###### Pytorch
export PYTORCH_ENABLE_MPS_FALLBACK=1
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0


# Test
testfunc () {
print "test"
export TEST='tester'
}
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

. "$HOME/.cargo/env"
eval "$(atuin init zsh)"


###### Zoxide
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

###### Starship
# https://starship.rs/guide/
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/dotfiles/.starship.toml


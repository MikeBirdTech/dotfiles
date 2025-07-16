# Aliases

# zsh
alias rezsh="source ~/.zshrc"

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gpu='git pull'
alias gp='git push'
alias glo='git log --oneline --decorate --color'
alias gb='git branch'

# Tools
alias cat="bat"
alias ls="eza"
alias ll="eza -la --hyperlink --icons --git"
alias pmpip="python -m pip"
alias grep='rg'
alias find='fd'
alias tree='eza --tree'
alias tree2='eza --tree --level=2'
alias tree3='eza --tree --level=3'
alias list='eza --tree --icons --all'

# Python
alias activate='source .venv/bin/activate'

# Function aliases
# Check if scripts exist before creating an alias
if [ -x "$SCRIPT_PATH/obsidian_backup.sh" ]; then
    alias obsidian_backup="obsidian_backup.sh"
fi
if [ -x "$SCRIPT_PATH/daily_focus.py" ]; then
    alias daily_focus='daily_focus.py'
fi
if [ -x "$SCRIPT_PATH/activity_tracker.py" ]; then
    alias lfg='activity_tracker.py'
fi

# SSH
if [ -x "$SCRIPT_PATH/ssh_aipi.sh" ]; then
    alias aipi='ssh_aipi.sh'
fi

# AI
alias ai='noglob sh -c "uv run --project /Users/mike/Code/scripts ai_cli.py \"\$@\"" --'

# Cheat sheet
alias '?'='cheat'   # so you can just type "?" then Enter

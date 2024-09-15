# Aliases

#zsh
alias rezsh="source ~/.zshrc"

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Git
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
alias get_latest_oi='pip install --upgrade --force-reinstall git+https://github.com/OpenInterpreter/open-interpreter.git'

# Tools
alias cat="bat"
alias ls="eza"
alias ll="ls -la"
alias pmpip="python -m pip"
alias code="cursor"

# Function aliases
alias obsidian_backup="obsidian_backup.sh"
alias daily_focus='daily_focus.py'
alias lfg='activity_tracker.py'

# SSH
alias aipi='ssh_aipi.sh'

# AI
alias ai='noglob ai_cli'

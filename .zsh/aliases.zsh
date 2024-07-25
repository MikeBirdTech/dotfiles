# Aliases
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

# Tools
alias cat="bat"
alias ls="eza"
alias ll="ls -la"
alias pmpip="python -m pip"
alias code="cursor"

# Function aliases
alias ai='noglob cli_ai'
alias obsidian_backup="obsidian_backup.sh"

# Video Helpers
# Generate subtitles for a video. Provide path to video as argument
# Usage: generate_subtitles /path/to/video.mp4
alias generate_subtitles='generate_subtitles.py'
# Generate thumbnail for a video
# Usage: generate_thumbnail /path/to/video.mp4
alias generate_thumbnail='generate_thumbnail.py'

# SSH
alias aipi='ssh_aipi.sh'

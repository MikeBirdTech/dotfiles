# Custom Functions

# Have AI generate a git commit message with 'aicommit'
aicommit() {
  ai_git_commit.py --service groq --vim "$@"
}

# Ask the AI for a CLI command
ai_cli() {
    "ai_cli.py" --service groq "$@"
}

# Sync my fork with the main Open Interpreter repo
sync_oi() {
    local repo_dir="/Users/mike/Code/open-interpreter"
    local fork_url="MikeBirdTech/open-interpreter"
    local branch="main"
    local verbose=""

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --branch)
                branch="$2"
                shift 2
                ;;
            --verbose)
                verbose="--verbose"
                shift
                ;;
            *)
                echo "Unknown option: $1"
                return 1
                ;;
        esac
    done

    sync_repo.py --repo-dir "$repo_dir" --fork-url "$fork_url" --branch "$branch" $verbose
}

# mkdir + cd
mkcd() { mkdir -p "$@" && cd "$_"; }

# git clone a repo and cd into it
gccd() {
    git clone $1
    cd $(echo $1 | grep -oE '([^/]+)\.git$' | sed 's/\.git$//')
}

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

# Video helpers
# Generate subtitles for a video. Provide path to video as argument
# Usage: generate_subtitles /path/to/video.mp4
generate_subtitles() {
    generate_subtitles.py "$@"
}

# Generate thumbnail for a video
# Usage: generate_thumbnail /path/to/video.mp4
generate_thumbnail() {
    generate_thumbnail.py "$@"
}

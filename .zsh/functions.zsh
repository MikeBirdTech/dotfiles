aicm() {
  ai_git_commit.py --service groq --vim "$@"
}

# ---------- fix‑assistant hooks & command ------------------
# ❶  Capture the command and its real‑time stderr *only* when it fails
function _fix_preexec() {
  FIX_CMD="$1"
  FIX_ERR_FILE=$(mktemp -t fix.XXXX)              # temp file for stderr
  exec 3>&2 2> >(tee -a "$FIX_ERR_FILE" >&2)      # tee stderr to file
}
function _fix_precmd() {
  local ec=$?                                     # exit code of last cmd
  # Only restore stderr if file descriptor 3 exists (i.e., _fix_preexec was called)
  if [[ -e /dev/fd/3 ]]; then
    exec 2>&3 3>&-                                # restore stderr
  fi
  if (( ec )); then                               # only remember failures
    export FIX_LAST_CMD="$FIX_CMD"
    export FIX_LAST_ERR_FILE="$FIX_ERR_FILE"
  else
    rm -f "$FIX_ERR_FILE"                         # clean up successes
  fi
}
preexec_functions+=(_fix_preexec)
precmd_functions+=(_fix_precmd)

# ❷  The `fix` command you’ll type after a failure
function fix() {
  local suggestion
  suggestion=$(python3 ~/scripts/fix 2>/dev/null)
  if [[ -n $suggestion ]]; then
    print -z -- "$suggestion"                     # inject into prompt
  else
    print -- "fix: nothing to suggest." >&2
  fi
}
# -----------------------------------------------------------

# Replace this with a more generic function that can be used for any repo
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

# Cross-platform clipboard utilities
_clip() {                     # internal helper: cross-platform clipboard
  if command -v pbcopy &>/dev/null; then pbcopy
  elif command -v xclip &>/dev/null; then xclip -selection clipboard
  elif command -v wl-copy &>/dev/null; then wl-copy
  else print "No clipboard tool" >&2; return 1; fi
}

copy() {
  if [[ -t 0 && $# -gt 0 ]]; then         # called as: copy file.txt
    cat -- "$@" | _clip
  else                                    # called in a pipe
    _clip
  fi
}

# Interactive cheat sheet for aliases and functions
cheat() {
  {
    echo "# Aliases" && alias
    echo "# Functions" && declare -f | sed -n 's/^\([^ ]*\) () .*/\1/p' | grep -v '^_'
  } | fzf --header='Type ⏎ to copy' \
      --preview='if [[ {} == *"="* ]]; then echo {}; else type $(echo {} | cut -d" " -f1); fi' \
      --bind 'enter:execute-silent(echo -n {} | cut -d"=" -f1 | cut -d" " -f1 | pbcopy)+abort'
}

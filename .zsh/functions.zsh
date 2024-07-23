# Custom Functions

# Have AI generate a git commit message with 'aicommit'
aicommit() {
  ai_git_commit.py
}

# Ask the AI for a CLI command with 'ai'
cli_ai() {
  setopt local_options no_glob
  python "$SCRIPT_PATH/cli_ai.py" "$@"
}


# Get the latest version of OI from git
get_latest_oi() {
  pip install --upgrade --force-reinstall git+https://github.com/OpenInterpreter/open-interpreter.git
}

# Sync my fork with the main repo
sync_oi() {
  sync_oi.py
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

# Test function
testfunc () {
print "test"
export TEST='tester'
}
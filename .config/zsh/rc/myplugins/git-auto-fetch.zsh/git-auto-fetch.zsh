# shellcheck disable=SC1009,SC1035,SC1072,SC1073
_GIT_AUTO_FETCH_INTERVAL=300

_git_auto_fetch() {
  local git_dir
  git_dir=$(git rev-parse --git-dir 2>/dev/null) || return

  local now=$(date +%s)
  local last_fetch=0
  local fetch_head="$git_dir/FETCH_HEAD"

  if [[ -f "$fetch_head" ]]; then
    last_fetch=$(stat -c %Y "$fetch_head" 2>/dev/null)
  fi

  if (( now - last_fetch > _GIT_AUTO_FETCH_INTERVAL )); then
    git fetch --quiet &>/dev/null &!
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _git_auto_fetch

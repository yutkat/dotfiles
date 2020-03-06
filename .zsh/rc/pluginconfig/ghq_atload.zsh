
alias ghq-repos="ghq list -p | fzf --prompt 'GHQ> ' --height 40% --reverse"
alias ghq-repo='cd $(ghq-repos)'

function cd-fzf-ghqlist-widget() {
  local GHQ_ROOT
  GHQ_ROOT=$(ghq root)
  local REPO
  REPO=$(ghq list -p | xargs ls -dt1 | sed -e 's;'${GHQ_ROOT}/';;g' | fzf +m --prompt 'GHQ> ' --height 40% --reverse)
  if [ -n "${REPO}" ]; then
    BUFFER="cd ${GHQ_ROOT}/${REPO}"
  fi
  zle accept-line
}
zle -N cd-fzf-ghqlist-widget
bindkey '^Xq' cd-fzf-ghqlist-widget
bindkey '^@' cd-fzf-ghqlist-widget

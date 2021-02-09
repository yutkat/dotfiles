zstyle ':completion:*' extra-verbose yes
#zstyle ':completion:list-expand:*' extra-verbose yes
#zstyle ':autocomplete:*' max-lines 80%
#zstyle ':autocomplete:tab:*' insert-unambiguous yes
#zstyle ':autocomplete:tab:*' widget-style menu-select
#zstyle ':autocomplete:*' config off
#zstyle ':autocomplete:*' min-delay .3
zstyle ':autocomplete:tab:*' widget-style menu-complete
zstyle ':autocomplete:tab:*' fzf-completion no
#zstyle ':autocomplete:*' magic off
#zstyle ':autocomplete:*' fuzzy-search off
#zstyle ':autocomplete:*' key-binding off
#zstyle ':autocomplete:*' config off
#zstyle ':completion:*' tag-order '! history-words recent-directories recent-files' '-'
#zstyle ':completion:*:complete:*:' tag-order \
#  '! history-words ancestor-directories recent-directories recent-files' -
zstyle ':completion:*:complete:*:' group-order \
  options arguments values local-directories files builtins

autoload -Uz add-zle-hook-widget
if ! builtin command -v compinit > /dev/null 2>&1; then
  autoload -Uz compinit && compinit -u
fi

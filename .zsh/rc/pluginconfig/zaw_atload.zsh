autoload -Uz is-at-least
if is-at-least 4.3.11; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 500 # cdrの履歴を保存する個数
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi
zstyle ':filter-select:highlight' selected fg=black,bg=white,standout
zstyle ':filter-select' case-insensitive yes
#bindkey '^@' zaw-cdr
bindkey '^Xf' zaw-git-files
bindkey '^Xc' zaw-git-branches
bindkey '^Xp' zaw-process
bindkey '^Xa' zaw-tmux


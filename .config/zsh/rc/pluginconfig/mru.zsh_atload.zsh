function _mru() {
  mru
  zle reset-prompt
}

zle -N _mru
bindkey '^X^P' _mru
bindkey '^Xp' _mru


function _mru() {
  mru
  zle reset-prompt
}

zle -N _mru
bindkey '^T' _mru


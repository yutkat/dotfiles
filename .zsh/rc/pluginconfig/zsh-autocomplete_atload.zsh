zstyle ':autocomplete:list-choices:*' max-lines 90%
zstyle ':autocomplete:*' groups always
zstyle ':autocomplete:tab:*' completion select
zstyle ':autocomplete:tab:*' completion cycle

function precmd_remove_up_down_bindkey() {
  bindkey '^[OA' up-line-or-history
  bindkey '^[OB' down-line-or-history
}

add-zsh-hook precmd precmd_remove_up_down_bindkey

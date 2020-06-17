zstyle ':autocomplete:list-choices:*' max-lines 90%
# quotation is missing bug eg. `git commit -m "xxx yyy"``
# zstyle ':autocomplete:*' groups always
zstyle ':autocomplete:tab:*' completion cycle
zstyle ':autocomplete:*' magic off

function precmd_remove_up_down_bindkey() {
  bindkey '^[OA' up-line-or-history
  bindkey '^[OB' down-line-or-history
}

add-zsh-hook precmd precmd_remove_up_down_bindkey

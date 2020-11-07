function precmd_overwrite_options() {
  zstyle ':completion:*:default' menu select=1
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_overwrite_options

bindkey $key[Up] up-line-or-history
bindkey $key[Down] down-line-or-history

bindkey -M menuselect '^H' vi-backward-char
bindkey -M menuselect '^K' vi-up-line-or-history
bindkey -M menuselect '^L' vi-forward-char
bindkey -M menuselect '^J' vi-down-line-or-history

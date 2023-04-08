bindkey '^[[A' up-line-or-history
bindkey '^[OA' up-line-or-history
# up-line-or-search:  Open history menu.
# up-line-or-history: Cycle to previous history line.

bindkey '^[[B' down-line-or-history
bindkey '^[OB' down-line-or-history
# down-line-or-select:  Open completion menu.
# down-line-or-history: Cycle to next history line.

#bindkey $key[Control-Space] list-expand
# list-expand:      Reveal hidden completions.
# set-mark-command: Activate text selection.

#bindkey -M menuselect $key[Return] .accept-line
# .accept-line: Accept command line.
# accept-line:  Accept selection and exit menu.

bindkey -M menuselect '^H' vi-backward-char
bindkey -M menuselect '^K' vi-up-line-or-history
bindkey -M menuselect '^L' vi-forward-char
bindkey -M menuselect '^J' vi-down-line-or-history

bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

zstyle ':completion:*:complete:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:list-expand:*' completer _expand _complete _ignored
#function precmd_overwrite_options() {
#  # $ZDATADIR/zinit/plugins/marlonrichert---zsh-autocomplete/module/.autocomplete.config
#  zstyle ':completion:*:complete:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
#  zstyle ':completion:*:default' menu select=1
#  zstyle -d ':completion:*' matcher
#}
#
#autoload -Uz add-zsh-hook
#add-zsh-hook precmd precmd_overwrite_options

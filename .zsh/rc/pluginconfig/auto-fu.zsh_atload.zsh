# overwrite bindkey
bindkey() {
  if [[ "$#" -eq 2 && "${1:0:1}" != '-' ]]; then
    builtin bindkey -M afu $@
  elif [ "$#" -eq 0 ]; then
    builtin bindkey -M afu
  else
    builtin bindkey $@
  fi
}
function zle-line-init () {
  auto-fu-init
}
zle -N zle-line-init
#zle_highlight=(default:fg=white)
zstyle ':auto-fu:var' postdisplay $''
## Enterを押したときは自動補完された部分を利用しない。
function afu+cancel-and-accept-line() {
  ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur" }
  zle afu+accept-line
}
zle -N afu+cancel-and-accept-line
bindkey "^M" afu+cancel-and-accept-line

### replace source command ###
# conflict to auto-fu and zsh-syntax-highlighting
# then source ~/.zshrc command is broken
function source_auto-fu_syntax_conflict() {
  if [[ "$1" = "$ZDOTDIR/.zshrc" ]];then
    exec zsh
  else
    source $@
  fi
}
alias source='source_auto-fu_syntax_conflict'


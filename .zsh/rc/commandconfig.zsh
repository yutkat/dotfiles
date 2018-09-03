
function existsCommand() {
  builtin command -v $1 > /dev/null 2>&1
}

function source-safe() { if [ -f "$1" ]; then source "$1"; fi }

#==============================================================#
## aws completion
#==============================================================#

if existsCommand aws_zsh_completer.sh; then
  source aws_zsh_completer.sh
fi


#==============================================================#
## terraform completion
#==============================================================#

if existsCommand terraform; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /usr/bin/terraform terraform
fi


#==============================================================#
## direnv
#==============================================================#

if existsCommand direnv; then
  eval "$(direnv hook zsh)"
fi


#==============================================================#
## fzf
#==============================================================#

# Don't move. It will break if you write if after pluginconfig
source-safe "$HOME/.fzf.zsh"
source-safe "$HOME/.fzf/shell/key-bindings.zsh"

if existsCommand fzf; then
  fzf-z-search() {
    local res=$(j | sort -rn | cut -c 12- | fzf --height 40% --reverse)
    if [ -n "$res" ]; then
      BUFFER+="cd $res"
      zle accept-line
    else
      zle redisplay
      return 1
    fi
  }
  zle -N fzf-z-search
  bindkey '^F' fzf-z-search
fi



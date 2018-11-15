
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

if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  export PATH="$PATH:$HOME/.fzf/bin"
fi
source-safe "$HOME/.fzf/shell/key-bindings.zsh"

if existsCommand fzf; then
  fzf-z-search() {
    local res=$(j | sort -rn | cut -c 12- | fzf --prompt 'FindFile> ' --height 40% --reverse)
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

  fzf-command-search() {
    LBUFFER="${LBUFFER}$(whence -pm '*' | xargs -i basename {} | fzf --prompt 'SearchCommand> ' --height 40% --reverse)"
    local ret=$?
    zle reset-prompt
    return $ret
  }
  zle -N fzf-command-search
  bindkey '^@' fzf-command-search

fi


#==============================================================#
## pip completion
#==============================================================#

if existsCommand pip; then
  function _pip_completion {
    local words cword
    read -Ac words
    read -cn cword
    reply=( $( COMP_WORDS="$words[*]" \
               COMP_CWORD=$(( cword-1 )) \
               PIP_AUTO_COMPLETE=1 $words[1] ) )
  }
  compctl -K _pip_completion pip
fi


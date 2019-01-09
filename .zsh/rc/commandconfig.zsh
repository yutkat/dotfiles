
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

  __gsel() {
    local cmd="command git ls-files"
    setopt localoptions pipefail 2> /dev/null
    eval "$cmd" | $(__fzfcmd) --prompt 'GitFiles> ' --height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS -m "$@" | while read item; do
      echo -n "${(q)item} "
    done
    local ret=$?
    echo
    return $ret
  }

  fzf-git-files-widget() {
    LBUFFER="${LBUFFER}$(__gsel)"
    local ret=$?
    zle reset-prompt
    return $ret
  }
  zle     -N   fzf-git-files-widget
  bindkey '^B' fzf-git-files-widget

  function gadd() {
    local selected
    selected=$(unbuffer git status -s | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
    if [[ -n "$selected" ]]; then
      selected=$(tr '\n' ' ' <<< "$selected")
      git add $selected
      echo "Completed: git add $selected"
    fi
  }
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


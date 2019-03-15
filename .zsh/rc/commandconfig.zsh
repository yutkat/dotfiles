
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

export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.*" -printf "%T@\t%p\n" | sort -rn | cut -f 2-'
# export FZF_DEFAULT_OPTS='--preview "
# if [[ $(file --mime {}) =~ directory ]]; then
#   echo {} is a directory
# elif [[ $(file --mime {}) =~ binary ]]; then
#   echo {} is a binary file;
# else
#   (highlight -O ansi -l {} || coderay {} || rougify {} || bat --color=always {} || cat {}) 2> /dev/null
# fi | head -500"'

# if existsCommand fd; then
#   export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# fi

if existsCommand fzf; then
  function fzf-z-search() {
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
  bindkey '^Xs' fzf-z-search

  function fzf-command-search-widget() {
    LBUFFER="${LBUFFER}$(whence -pm '*' | xargs -i basename {} | fzf --prompt 'SearchCommand> ' --height 40% --reverse)"
    local ret=$?
    zle reset-prompt
    return $ret
  }
  zle -N fzf-command-search-widget
  bindkey '^@' fzf-command-search-widget
  bindkey '^Xc' fzf-command-search-widget

  function __gsel() {
    local cmd="command git ls-files"
    setopt localoptions pipefail 2> /dev/null
    eval "$cmd" | $(__fzfcmd) --prompt "GitFiles> " --height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_CTRL_T_OPTS -m "$@" | while read item; do
      echo -n "${(q)item} "
    done
    local ret=$?
    echo
    return $ret
  }

  function fzf-git-files-widget() {
    LBUFFER="${LBUFFER}$(__gsel)"
    local ret=$?
    zle reset-prompt
    return $ret
  }
  zle     -N   fzf-git-files-widget
  bindkey '^B' fzf-git-files-widget
  bindkey '^Xg' fzf-git-files-widget

  function gadd() {
    local selected
    selected=$(unbuffer git status -s | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
    if [[ -n "$selected" ]]; then
      selected=$(tr '\n' ' ' <<< "$selected")
      git add $selected
      echo "Completed: git add $selected"
    fi
  }

  function vim-fzf-find() {
    local FILE=$(find ./ -path '*/\.*' -name .git -prune -o -type f -print 2> /dev/null | fzf +m)
    if [ -n "$FILE" ]; then
      ${EDITOR:-vim} $FILE
    fi
  }
  alias fzf-vim=vim-fzf-find
  zle     -N   vim-fzf-find
  bindkey '^Xv' vim-fzf-find

  if existsCommand ghq; then
    function cd-fzf-ghqlist-widget() {
      local GHQ_ROOT=`ghq root`
      local REPO=`ghq list -p | sed -e 's;'${GHQ_ROOT}/';;g' |fzf +m`
      if [ -n "${REPO}" ]; then
        BUFFER="cd ${GHQ_ROOT}/${REPO}"
      fi
      zle accept-line
    }
    zle -N cd-fzf-ghqlist-widget
    bindkey '^Xq' cd-fzf-ghqlist-widget
  fi
fi


#==============================================================#
## pip completion
#==============================================================#

if existsCommand pip; then
  function _pip_completion() {
    local words cword
    read -Ac words
    read -cn cword
    reply=( $( COMP_WORDS="$words[*]" \
      COMP_CWORD=$(( cword-1 )) \
      PIP_AUTO_COMPLETE=1 $words[1] ) )
    }
  compctl -K _pip_completion pip
fi


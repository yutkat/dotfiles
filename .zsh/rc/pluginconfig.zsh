
function isLoadedPluginSafe() {
  if ! builtin command -v isLoadedPlugin > /dev/null 2>&1; then
    return 1
  fi
  isLoadedPlugin $1
}


#==============================================================#
## zsh-git-prompt                                             ##
#==============================================================#

if isLoadedPluginSafe "zsh-git-prompt"; then
  ZSH_THEME_GIT_PROMPT_PREFIX="("
  ZSH_THEME_GIT_PROMPT_SUFFIX=")"
  ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
  ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[cyan]%}"
  ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[yellow]%}%{+%G%}"
  ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[magenta]%}%{!%G%}"
  ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg_bold[red]%}%{*%G%}"
  ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[blue]%}%{<%G%}"
  ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[blue]%}%{>%G%}"
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[white]%}%{?%G%}"
  ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{/%G%}"
fi


#==============================================================#
## zaw                                                        ##
#==============================================================#

if isLoadedPluginSafe "zaw"; then
  autoload -Uz is-at-least
  if is-at-least 4.3.11; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':chpwd:*' recent-dirs-max 500 # cdrの履歴を保存する個数
    zstyle ':chpwd:*' recent-dirs-default yes
    zstyle ':completion:*' recent-dirs-insert both
  fi
  zstyle ':filter-select:highlight' selected fg=black,bg=white,standout
  zstyle ':filter-select' case-insensitive yes
  #bindkey -M $BIND_OPTION '^@' zaw-cdr
  bindkey -M $BIND_OPTION '^Xf' zaw-git-files
  bindkey -M $BIND_OPTION '^Xc' zaw-git-branches
  bindkey -M $BIND_OPTION '^Xp' zaw-process
  bindkey -M $BIND_OPTION '^Xa' zaw-tmux
fi


#==============================================================#
## auto-fu.zsh                                                ##
#==============================================================#

if isLoadedPluginSafe "auto-fu.zsh"; then
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
  BIND_OPTION="afu"
  bindkey -M $BIND_OPTION "^M" afu+cancel-and-accept-line
fi


#==============================================================#
##    z                                                       ##
#==============================================================#

if isLoadedPluginSafe "z"; then
  precmd() {
    _z --add "$(pwd -P)"
  }
fi


#==============================================================#
## zsh-syntax-highlighting                                    ##
#==============================================================#

if isLoadedPluginSafe "zsh-syntax-highlighting"; then
  #ZSH_HIGHLIGHT_STYLES[default]=none
  #ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
  #ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow
  #ZSH_HIGHLIGHT_STYLES[alias]=fg=green
  #ZSH_HIGHLIGHT_STYLES[builtin]=fg=green
  #ZSH_HIGHLIGHT_STYLES[function]=fg=green
  #ZSH_HIGHLIGHT_STYLES[command]=fg=green
  #ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
  #ZSH_HIGHLIGHT_STYLES[commandseparator]=none
  #ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=green
  #ZSH_HIGHLIGHT_STYLES[path]=underline
  #ZSH_HIGHLIGHT_STYLES[path_prefix]=underline
  #ZSH_HIGHLIGHT_STYLES[path_approx]=fg=yellow,underline
  ZSH_HIGHLIGHT_STYLES[globbing]=fg=magenta
  ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=magenta
  #ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
  #ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
  #ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
  #ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
  #ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
  #ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
  #ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
  #ZSH_HIGHLIGHT_STYLES[assign]=none
fi


#==============================================================#
## anyframe
#==============================================================#

if isLoadedPluginSafe "anyframe"; then
  bindkey -M $BIND_OPTION '^@' anyframe-widget-put-history
  bindkey -M $BIND_OPTION '^Xb' anyframe-widget-cdr
  bindkey -M $BIND_OPTION '^X^B' anyframe-widget-checkout-git-branch
  #bindkey -M $BIND_OPTION '^Xr' anyframe-widget-execute-history
  bindkey -M $BIND_OPTION '^X^R' anyframe-widget-execute-history
  #bindkey -M $BIND_OPTION '^Xp' anyframe-widget-put-history
  bindkey -M $BIND_OPTION '^X^P' anyframe-widget-put-history
  #bindkey -M $BIND_OPTION '^Xg' anyframe-widget-cd-ghq-repository
  bindkey -M $BIND_OPTION '^X^G' anyframe-widget-cd-ghq-repository
  #bindkey -M $BIND_OPTION '^Xk' anyframe-widget-kill
  bindkey -M $BIND_OPTION '^X^K' anyframe-widget-kill
  #bindkey -M $BIND_OPTION '^Xi' anyframe-widget-insert-git-branch
  bindkey -M $BIND_OPTION '^X^I' anyframe-widget-insert-git-branch
  #bindkey -M $BIND_OPTION '^Xf' anyframe-widget-insert-filename
  bindkey -M $BIND_OPTION '^X^F' anyframe-widget-insert-filename
fi


#==============================================================#
## emoji-cli
#==============================================================#

if isLoadedPluginSafe "emoji-cli"; then
  bindkey -M $BIND_OPTION '^x^e' emoji::cli
  bindkey -M $BIND_OPTION '^xe'  emoji::cli
fi


#==============================================================#
## aws completion
#==============================================================#

if builtin command -v aws_zsh_completer.sh 1>/dev/null 2>&1; then
  source aws_zsh_completer.sh
fi


#==============================================================#
## terraform completion
#==============================================================#

if builtin command -v terraform 1>/dev/null 2>&1; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /usr/bin/terraform terraform
fi


#==============================================================#
## direnv
#==============================================================#

if builtin command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi


#==============================================================#
## fzf
#==============================================================#

if builtin command -v fzf 1>/dev/null 2>&1; then
  fzf-z-search() {
    local res=$(j | sort -rn | cut -c 12- | fzf)
    if [ -n "$res" ]; then
      BUFFER+="cd $res"
      zle accept-line
    else
      return 1
    fi
  }
  bindkey -M $BIND_OPTION '^f' fzf-z-search
fi


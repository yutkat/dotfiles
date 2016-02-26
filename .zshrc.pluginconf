
#--------------------------------------------------------------#
## zsh-git-prompt                                             ##
#--------------------------------------------------------------#

if [[ -n "$ZSH_THEME_GIT_PROMPT_PREFIX" ]]; then
  ZSH_THEME_GIT_PROMPT_PREFIX="("
  ZSH_THEME_GIT_PROMPT_SUFFIX=")"
  ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
  ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[cyan]%}"
  ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[yellow]%}%{+%G%}"
  ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[magenta]%}%{!%G%}"
  ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg_bold[red]%}%{*%G%}"
  ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[blue]%}%{v%G%}"
  ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[blue]%}%{^%G%}"
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[white]%}%{?%G%}"
  ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{/%G%}"
fi


#--------------------------------------------------------------#
## zaw                                                        ##
#--------------------------------------------------------------#

if type zaw > /dev/null 2>&1; then
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
fi


#--------------------------------------------------------------#
## auto-fu.zsh                                                ##
#--------------------------------------------------------------#

if type auto-fu-init > /dev/null 2>&1; then
  function zle-line-init () {
    auto-fu-init
  }
  zle -N zle-line-init
  #zle_highlight=(default:fg=white)
  zstyle ':auto-fu:var' postdisplay $''
  ## Enterを押したときは自動補完された部分を利用しない。
  afu+cancel-and-accept-line() {
    ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur" }
    zle afu+accept-line
  }
  zle -N afu+cancel-and-accept-line
  export BIND_OPTION="afu"
fi


#--------------------------------------------------------------#
##    z                                                       ##
#--------------------------------------------------------------#

if type _z > /dev/null 2>&1; then
  precmd() {
    _z --add "$(pwd -P)"
  }
fi


#--------------------------------------------------------------#
## zsh-syntax-highlighting                                    ##
#--------------------------------------------------------------#

if [[ -n "$ZSH_HIGHLIGHT_STYLES" ]]; then
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



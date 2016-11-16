
#==============================================================#
## Setup zplug                                                ##
#==============================================================#

ZPLUG_HOME="$ZHOMEDIR/zplug"
if [[ ! -d "$ZPLUG_HOME" ]];then
  git clone https://github.com/zplug/zplug.git "$ZPLUG_HOME"
  source "$ZPLUG_HOME/init.zsh" && zplug update --self
fi

source "$ZPLUG_HOME/init.zsh"


#==============================================================#
## Plugin Pre Setting                                         ##
#==============================================================#

# z #
_Z_CMD=j
_Z_DATA="$ZHOMEDIR/.z"

# enhancd #
export ENHANCD_COMMAND=dc


#==============================================================#
## Plugin load                                                ##
#==============================================================#

zplug "zplug/zplug"
zplug "olivierverdier/zsh-git-prompt", use:"*.sh"
zplug "zsh-users/zaw"
zplug "hchbaw/auto-fu.zsh", at:pu
zplug "rupa/z", use:"*.sh"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", nice:10, if:"(( ${ZSH_VERSION%%.*} > 4.4))"
zplug "zsh-users/zsh-history-substring-search", if:"(( ${ZSH_VERSION%%.*} > 4.3))"
zplug "mollifier/cd-gitroot"
zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "b4b4r07/zsh-gomi", if:"which fzf"
zplug "mollifier/anyframe"

# old plugins
#zplug "autojump" # ->z
#zplug "tarruda/zsh-autosuggestions" # ->auto-fu

[ -f "$HOME/.zshrc.zplug.local" ] && source "$HOME/.zshrc.zplug.local"


#==============================================================#
## Plugin install                                             ##
#==============================================================#

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load


#==============================================================#
## Install Check Function
#==============================================================#

function isLoadedPlugin() {
  zplug list | cut -d' ' -f1 | \
    sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | \
    grep "/$1$" > /dev/null 2>&1
}


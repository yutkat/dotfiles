
#==============================================================#
## Setup zplug                                                ##
#==============================================================#

ZPLUG_HOME="$ZHOMEDIR/zplug"
if [[ ! -d "$ZPLUG_HOME" ]];then
  git clone --depth 1 https://github.com/zplug/zplug.git "$ZPLUG_HOME"
fi

source "$ZPLUG_HOME/init.zsh"


#==============================================================#
## Plugin Pre Setting                                         ##
#==============================================================#

# z #
_Z_CMD=j
_Z_DATA="$ZHOMEDIR/.z"

# enhancd #
export ENHANCD_COMMAND=ecd


#==============================================================#
## Plugin load                                                ##
#==============================================================#

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# completion
zplug 'hchbaw/auto-fu.zsh', at:pu
zplug 'zsh-users/zsh-completions'

# prompt
zplug 'olivierverdier/zsh-git-prompt', use:"*.sh"
zplug 'zsh-users/zsh-syntax-highlighting', defer:2, if:"(( ${ZSH_VERSION%%.*} > 4.4))"

# history
zplug 'zsh-users/zsh-history-substring-search', if:"(( ${ZSH_VERSION%%.*} > 4.3))"
zplug 'larkery/zsh-histdb'

# alias
zplug 'unixorn/git-extra-commands'

# environment variable
zplug 'Tarrasch/zsh-autoenv'

# fuzzy finder
zplug 'junegunn/fzf-bin', as:command, from:gh-r, rename-to:fzf
zplug 'junegunn/fzf', as:command, use:bin/fzf-tmux

# improve cd
zplug 'vincpa/z', use:"*.sh"
zplug 'mollifier/cd-gitroot'
zplug 'peterhurford/up.zsh'
zplug 'b4b4r07/enhancd', use:init.sh
zplug 'Tarrasch/zsh-bd'
zplug 'jocelynmallon/zshmarks'

# enhancive command
zplug 'supercrabtree/k' # ls

# extension
zplug 'b4b4r07/emoji-cli'
zplug 't413/zsh-background-notify'
zplug 'b4b4r07/zsh-gomi', if:"which fzf"
zplug 'popstas/zsh-command-time'


# old plugins
#zplug "autojump" # ->z
#zplug "tarruda/zsh-autosuggestions" # ->auto-fu
#zplug 'mollifier/anyframe' # -> fzf
#zplug 'zsh-users/zaw' # -> fzf

[ -f "$HOME/.zshrc.zplug.local" ] && source "$HOME/.zshrc.zplug.local"


#==============================================================#
## Plugin install                                             ##
#==============================================================#

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -rq; then
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


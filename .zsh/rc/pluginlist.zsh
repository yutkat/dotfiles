
#==============================================================#
## Setup zplugin                                              ##
#==============================================================#

if [ -z "$ZPLG_HOME" ]; then
    ZPLG_HOME="${ZHOMEDIR:-$HOME}/zplugin"
fi

if ! test -d "$ZPLG_HOME"; then
    mkdir "$ZPLG_HOME"
    chmod g-rwX "$ZPLG_HOME"
    git clone --depth 10 https://github.com/zdharma/zplugin.git ${ZPLG_HOME}/bin
fi

typeset -gAH ZPLGM
ZPLGM[HOME_DIR]="${ZPLG_HOME}"
source "$ZPLG_HOME/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin


#==============================================================#
## Plugin load                                                ##
#==============================================================#

#--------------------------------#
# prompt
#--------------------------------#
git_version=$(git --version | head -n1 | cut -d" " -f3)
if [[ "$(version3 "$git_version")" -ge "$(version3 "2.11.0")" ]]; then
  zplugin ice atload"source $ZHOMEDIR/rc/pluginconfig/git-prompt_atload.zsh"
  zplugin light 'woefe/git-prompt.zsh'
else
  zplugin ice atload"source $ZHOMEDIR/rc/pluginconfig/zsh-git-prompt_atload.zsh"
  zplugin light 'olivierverdier/zsh-git-prompt'
fi

zplugin ice wait'!0' lucid if"(( ${ZSH_VERSION%%.*} > 4.4))" atinit"zpcompinit; zpcdreplay"
zplugin light 'zdharma/fast-syntax-highlighting'

#--------------------------------#
# completion
#--------------------------------#
zplugin ice ver:pu atload"source $ZHOMEDIR/rc/pluginconfig/auto-fu.zsh_atload.zsh"
zplugin light 'hchbaw/auto-fu.zsh'

zplugin ice wait'!0' lucid as"completion" atload"source $ZHOMEDIR/rc/pluginconfig/zsh-completions_atload.zsh"
zplugin light 'zsh-users/zsh-completions'

#--------------------------------#
# history
#--------------------------------#
zplugin ice wait'!0' lucid if"(( ${ZSH_VERSION%%.*} > 4.4))"
zplugin light 'zsh-users/zsh-history-substring-search'

zplugin ice wait'!0' lucid
zplugin light 'larkery/zsh-histdb'

#--------------------------------#
# alias
#--------------------------------#
zplugin ice wait'!0' lucid
zplugin light 'unixorn/git-extra-commands'

zplugin ice wait'!0' lucid atload"source $ZHOMEDIR/rc/pluginconfig/zsh-abbrev-alias_atinit.zsh"
zplugin light 'momo-lab/zsh-abbrev-alias'

#--------------------------------#
# environment variable
#--------------------------------#
zplugin light 'Tarrasch/zsh-autoenv'

#--------------------------------#
# improve cd
#--------------------------------#
zplugin ice atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-z_atinit.zsh"
zplugin light 'agkozak/zsh-z'

zplugin ice wait'!0' lucid
zplugin light 'mollifier/cd-gitroot'

zplugin ice wait'!0' lucid
zplugin light 'peterhurford/up.zsh'

zplugin ice wait'!0' lucid
zplugin light 'Tarrasch/zsh-bd'

zplugin ice wait'!0' lucid
zplugin light 'jocelynmallon/zshmarks'

#--------------------------------#
# enhancive command
#--------------------------------#
zplugin ice wait'!0' lucid
zplugin light 'supercrabtree/k' # ls

zplugin ice wait'!0' lucid pick"fzf-extras.zsh"
zplugin light 'atweiden/fzf-extras' # fzf

#--------------------------------#
# git
#--------------------------------#
# zplugin ice wait'!0' lucid # -> using as a alias in gitconfig
zplugin light 'caarlos0/zsh-git-sync'

#--------------------------------#
# extension
#--------------------------------#
zplugin ice wait'!0' lucid atload"source $ZHOMEDIR/rc/pluginconfig/emoji-cli_atload.zsh"
zplugin light 'b4b4r07/emoji-cli'

zplugin ice wait'!0' lucid
zplugin light 't413/zsh-background-notify'

# Too slow on ssh
# zplugin ice wait'!0' lucid atload"source $ZHOMEDIR/rc/pluginconfig/zsh-command-time_atload.zsh"
# zplugin light 'popstas/zsh-command-time'

#--------------------------------#
# program
#--------------------------------#
zplugin ice from"gh-r" as"program"
zplugin load "junegunn/fzf-bin"

zplugin ice wait'!0' lucid pick"asdf.sh" atload"source $ZPLG_HOME/plugins/asdf-vm---asdf/completions/asdf.bash" blockf nocompletions
zplugin light 'asdf-vm/asdf'


#==============================================================#
# old plugins
#==============================================================#

# asdf
#zplugin ice wait'!0' lucid as"program" pick:"bin/anyenv" if"[[ -d "$HOME/.config/anyenv/anyenv-install" ]]" atload'eval "$(anyenv init -)"'
#zplugin light anyenv/anyenv
# don't maintain
# zplugin ice pick"*.sh" atinit"source $ZHOMEDIR/rc/pluginconfig/z_atinit.zsh"
# zplugin light 'rupa/z'
# git-prompt
# zplugin ice lucid wait"0" atload"source $ZHOMEDIR/rc/pluginconfig/zsh-async_atload.zsh && set_async"
# zplugin light mafredri/zsh-async

# don't use
# zplugin ice wait'!0' lucid
# zplugin light 'b4b4r07/zsh-gomi'
#zsh-users/zsh-syntax-highlighting # -> zdharma/fast-syntax-highlighting
# move
# zplug 'hchbaw/zce.zsh' # -> don't move

# zplug 'felixr/docker-zsh-completion' # -> broken
# fuzzy finder
# unused
#zplug 'b4b4r07/enhancd', use:init.sh
#zplug 'junegunn/fzf-bin', as:command, from:gh-r, rename-to:fzf # -> zplug grep bug
#zplug 'junegunn/fzf', as:command, use:bin/fzf-tmux

#zplug "autojump" # ->z
#zplug "tarruda/zsh-autosuggestions" # ->auto-fu
#zplug 'mollifier/anyframe' # -> fzf
#zplug 'zsh-users/zaw' # -> fzf

[ -f "$HOME/.zshrc.plugin.local" ] && source "$HOME/.zshrc.plugin.local"



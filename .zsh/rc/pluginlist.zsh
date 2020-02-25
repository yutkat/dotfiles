
#==============================================================#
## Setup zinit                                              ##
#==============================================================#

if [ -z "$ZPLG_HOME" ]; then
    ZPLG_HOME="${ZHOMEDIR:-$HOME}/zinit"
fi

if ! test -d "$ZPLG_HOME"; then
    mkdir "$ZPLG_HOME"
    chmod g-rwX "$ZPLG_HOME"
    git clone --depth 10 https://github.com/zdharma/zinit.git ${ZPLG_HOME}/bin
fi

typeset -gAH ZPLGM
ZPLGM[HOME_DIR]="${ZPLG_HOME}"
source "$ZPLG_HOME/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


#==============================================================#
## Plugin load                                                ##
#==============================================================#

#--------------------------------#
# prompt
#--------------------------------#
git_version=$(git --version | head -n1 | cut -d" " -f3)
if [[ "$(version3 "$git_version")" -ge "$(version3 "2.11.0")" ]]; then
  zinit ice atload"source $ZHOMEDIR/rc/pluginconfig/git-prompt_atload.zsh"
  zinit light 'woefe/git-prompt.zsh'
else
  zinit ice atload"source $ZHOMEDIR/rc/pluginconfig/zsh-git-prompt_atload.zsh"
  zinit light 'olivierverdier/zsh-git-prompt'
fi

zinit ice wait'!0' lucid if"(( ${ZSH_VERSION%%.*} > 4.4))" atinit"zpcompinit; zpcdreplay"
zinit light 'zdharma/fast-syntax-highlighting'

#--------------------------------#
# completion
#--------------------------------#
zinit ice ver:pu atload"source $ZHOMEDIR/rc/pluginconfig/auto-fu.zsh_atload.zsh"
zinit light 'hchbaw/auto-fu.zsh'

zinit ice wait'!0' lucid as"completion" atload"source $ZHOMEDIR/rc/pluginconfig/zsh-completions_atload.zsh"
zinit light 'zsh-users/zsh-completions'

#--------------------------------#
# history
#--------------------------------#
zinit ice wait'!0' lucid if"(( ${ZSH_VERSION%%.*} > 4.4))"
zinit light 'zsh-users/zsh-history-substring-search'

zinit ice wait'!0' lucid
zinit light 'larkery/zsh-histdb'

#--------------------------------#
# alias
#--------------------------------#
zinit ice wait'!0' lucid
zinit light 'unixorn/git-extra-commands'

zinit ice wait'!0' lucid atload"source $ZHOMEDIR/rc/pluginconfig/zsh-abbrev-alias_atinit.zsh"
zinit light 'momo-lab/zsh-abbrev-alias'

#--------------------------------#
# environment variable
#--------------------------------#
zinit light 'Tarrasch/zsh-autoenv'

#--------------------------------#
# improve cd
#--------------------------------#
zinit ice atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-z_atinit.zsh"
zinit light 'agkozak/zsh-z'

zinit ice atinit"source $ZHOMEDIR/rc/pluginconfig/fz_atinit.zsh"
zinit light "changyuheng/fz"

zinit ice wait'!0' lucid
zinit light 'mollifier/cd-gitroot'

zinit ice wait'!0' lucid
zinit light 'peterhurford/up.zsh'

zinit ice wait'!0' lucid
zinit light 'Tarrasch/zsh-bd'

zinit ice wait'!0' lucid
zinit light 'jocelynmallon/zshmarks'

#--------------------------------#
# enhancive command
#--------------------------------#
zinit ice wait'!0' lucid
zinit light 'supercrabtree/k' # ls

zinit ice wait'!0' lucid pick"fzf-extras.zsh"
zinit light 'atweiden/fzf-extras' # fzf

#--------------------------------#
# git
#--------------------------------#
# zinit ice wait'!0' lucid # -> using as a alias in gitconfig
zinit light 'caarlos0/zsh-git-sync'

#--------------------------------#
# extension
#--------------------------------#
zinit ice wait'!0' lucid atload"source $ZHOMEDIR/rc/pluginconfig/emoji-cli_atload.zsh"
zinit light 'b4b4r07/emoji-cli'

zinit ice wait'!0' lucid
zinit light 't413/zsh-background-notify'

# Too slow on ssh
# zinit ice wait'!0' lucid atload"source $ZHOMEDIR/rc/pluginconfig/zsh-command-time_atload.zsh"
# zinit light 'popstas/zsh-command-time'

#--------------------------------#
# program
#--------------------------------#
zinit ice from"gh-r" as"program"
zinit load "junegunn/fzf-bin"

zinit ice wait'!0' lucid pick"asdf.sh"
zinit light 'asdf-vm/asdf'


#==============================================================#
# old plugins
#==============================================================#

# fz
#zinit ice wait'!0' lucid
#zinit light "andrewferrier/fzf-z"
# fasd Not updated recently
#zinit ice pick'fasd'
#zinit light 'clvv/fasd' atload'eval "$(fasd --init auto)"'
# asdf
#zinit ice wait'!0' lucid as"program" pick:"bin/anyenv" if"[[ -d "$HOME/.config/anyenv/anyenv-install" ]]" atload'eval "$(anyenv init -)"'
#zinit light anyenv/anyenv
# don't maintain
# zinit ice pick"*.sh" atinit"source $ZHOMEDIR/rc/pluginconfig/z_atinit.zsh"
# zinit light 'rupa/z'
# git-prompt
# zinit ice lucid wait"0" atload"source $ZHOMEDIR/rc/pluginconfig/zsh-async_atload.zsh && set_async"
# zinit light mafredri/zsh-async

# don't use
# zinit ice wait'!0' lucid
# zinit light 'b4b4r07/zsh-gomi'
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



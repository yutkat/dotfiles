#==============================================================#
## Setup zinit                                                ##
#==============================================================#
# cSpell:disable
if [ -z "$ZPLG_HOME" ]; then
	ZPLG_HOME="$ZDATADIR/zinit"
fi

if ! test -d "$ZPLG_HOME"; then
	mkdir -p "$ZPLG_HOME"
	chmod g-rwX "$ZPLG_HOME"
	git clone --depth 10 https://github.com/zdharma-continuum/zinit.git "${ZPLG_HOME}/bin"
fi

typeset -gAH ZPLGM
ZPLGM[HOME_DIR]="${ZPLG_HOME}"
source "$ZPLG_HOME/bin/zinit.zsh"
autoload -Uz _zinit
((${+_comps})) && _comps[zinit]=_zinit # shuck: ignore=C006 # zinit is an assoc-array key here

zinit lucid \
	light-mode for "$ZHOMEDIR/rc/myplugins/preload_command_config.zsh"
# mise activate costs ~55ms, so defer it; the ${commands[...]} checks below
# find mise tools through the shims dir added to PATH in .zshenv
zinit wait'0' lucid \
	light-mode for "$ZHOMEDIR/rc/myplugins/mise_activate.zsh"

#==============================================================#
## Plugin load                                                ##
#==============================================================#

#--------------------------------#
# zinit extension
#--------------------------------#

#--------------------------------#
# completion
#--------------------------------#
zinit wait'0b' lucid \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-autosuggestions_atload.zsh" \
	light-mode for @zsh-users/zsh-autosuggestions

zinit wait'0c' lucid nocompletions \
	atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-autocomplete_atinit.zsh" \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-autocomplete_atload.zsh" \
	light-mode for @marlonrichert/zsh-autocomplete

zinit wait'0b' lucid as"completion" \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-completions_atload.zsh" \
	light-mode for @zsh-users/zsh-completions

#--------------------------------#
# prompt
#--------------------------------#
zinit wait'0a' lucid \
	if"(( ${ZSH_VERSION%%.*} > 4.4))" \
	atinit"source $ZHOMEDIR/rc/pluginconfig/fast-syntax-highlighting_atinit.zsh" \
	atload"source $ZHOMEDIR/rc/pluginconfig/fast-syntax-highlighting.zsh" \
	light-mode for @zdharma-continuum/fast-syntax-highlighting

PROMPT="%~"$'\n'"> "
zinit wait'!0b' lucid depth=1 \
	atload"source $ZHOMEDIR/rc/pluginconfig/powerlevel10k_atload.zsh" \
	light-mode for @romkatv/powerlevel10k

#--------------------------------#
# history
#--------------------------------#

#--------------------------------#
# alias
#--------------------------------#
zinit wait'0' lucid \
	light-mode for @unixorn/git-extra-commands

#--------------------------------#
# environment variable
#--------------------------------#

#--------------------------------#
# improve cd
#--------------------------------#

#--------------------------------#
# git
#--------------------------------#

#--------------------------------#
# fzf
#--------------------------------#
zinit wait'1a' lucid \
	is-snippet for "$ZHOMEDIR/rc/pluginconfig/fzf_atload.zsh"

#--------------------------------#
# extension
#--------------------------------#
if [[ -z "$SSH_CONNECTION" ]]; then
	zinit wait'0' lucid \
		atload"source $ZHOMEDIR/rc/pluginconfig/zsh-auto-notify_atload.zsh" \
		light-mode for @MichaelAquilina/zsh-auto-notify
fi

zinit wait'0' lucid \
	light-mode for @mafredri/zsh-async

#--------------------------------#
# enhancive command
#--------------------------------#
if [ -n "${commands[eza]}" ]; then
	source "$ZHOMEDIR/rc/pluginconfig/eza_atload.zsh"
fi

if [ -n "${commands[rip]}" ]; then
	source "$ZHOMEDIR/rc/pluginconfig/rip_atload.zsh"
fi

#--------------------------------#
# program
#--------------------------------#
# neovim
source "$ZHOMEDIR/rc/pluginconfig/neovim_atload.zsh"

# GitHub #
if [ -n "${commands[gh]}" ]; then
	source "$ZHOMEDIR/rc/pluginconfig/gh_atload.zsh"
fi

# snippet
# stty -ixon for Ctrl+S is set in bindkey.zsh
zinit wait'1' lucid has'pet' \
	is-snippet for "$ZHOMEDIR/rc/pluginconfig/pet_atload.zsh"

#==============================================================#
# my plugins
#==============================================================#
zinit wait'1' lucid \
	light-mode for "$ZHOMEDIR/rc/myplugins/osc7.zsh"
zinit wait'1' lucid \
	as"program" pick"fzf-preview.sh" \
	light-mode for @yutkat/fzf-preview.sh
zinit wait'1' lucid \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-pbcopy_atload.zsh" \
	light-mode for @yutkat/zsh-pbcopy
zinit wait'1' lucid \
	atload"source $ZHOMEDIR/rc/pluginconfig/zsh-dir-history_atload.zsh" \
	light-mode for @yutkat/zsh-dir-history

#==============================================================#
# Analytics
#==============================================================#

#==============================================================#
# completion
#==============================================================#
zinit wait'2' lucid silent \
	light-mode for "$ZHOMEDIR/rc/myplugins/command_config.zsh"
zinit wait'1' lucid \
	light-mode for "$ZHOMEDIR/rc/myplugins/git-auto-fetch.zsh"

#==============================================================#
# local plugins
#==============================================================#
[ -f "$HOME/.zshrc.plugin.local" ] && source "$HOME/.zshrc.plugin.local"

#==============================================================#
# old plugins
#==============================================================#

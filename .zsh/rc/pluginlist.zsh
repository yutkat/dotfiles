
#==============================================================#
## Setup zinit                                                ##
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
# zinit extension
#--------------------------------#
zinit light-mode for \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node
  # zinit-zsh/z-a-man # -> require gem


#--------------------------------#
# prompt
#--------------------------------#
git_version=$(git --version | head -n1 | cut -d" " -f3)
if [[ "$(version3 "$git_version")" -ge "$(version3 "2.11.0")" ]]; then
  zinit ice lucid atload"source $ZHOMEDIR/rc/pluginconfig/git-prompt_atload.zsh"
  zinit light woefe/git-prompt.zsh
else
  zinit ice lucid atload"source $ZHOMEDIR/rc/pluginconfig/zsh-git-prompt_atload.zsh"
  zinit light olivierverdier/zsh-git-prompt
fi

zinit ice wait'!0c' lucid if"(( ${ZSH_VERSION%%.*} > 4.4))" atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

zinit ice lucid depth=1 atload"source $ZHOMEDIR/rc/pluginconfig/powerlevel10k_atload.zsh"
zinit light romkatv/powerlevel10k


#--------------------------------#
# completion
#--------------------------------#
zinit ice wait'!0a' lucid atload"source $ZHOMEDIR/rc/pluginconfig/zsh-autosuggestions_atload.zsh"
zinit light zsh-users/zsh-autosuggestions
zinit ice wait'!0b' lucid atload"source $ZHOMEDIR/rc/pluginconfig/zsh-autocomplete_atload.zsh"
zinit light marlonrichert/zsh-autocomplete

zinit ice wait'!0' lucid as"completion" atload"source $ZHOMEDIR/rc/pluginconfig/zsh-completions_atload.zsh"
zinit light zsh-users/zsh-completions


#--------------------------------#
# history
#--------------------------------#
zinit ice wait'0' lucid if"(( ${ZSH_VERSION%%.*} > 4.4))"
zinit light zsh-users/zsh-history-substring-search

zinit ice wait'0' lucid
zinit light larkery/zsh-histdb


#--------------------------------#
# alias
#--------------------------------#
zinit ice wait'0' lucid
zinit light unixorn/git-extra-commands

zinit ice wait'!0a' lucid atload"source $ZHOMEDIR/rc/pluginconfig/zsh-abbrev-alias_atinit.zsh"
zinit light momo-lab/zsh-abbrev-alias


#--------------------------------#
# environment variable
#--------------------------------#
zinit ice wait'!0' lucid
zinit light Tarrasch/zsh-autoenv


#--------------------------------#
# improve cd
#--------------------------------#
zinit ice wait'0' lucid atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-z_atinit.zsh"
zinit light agkozak/zsh-z

zinit ice wait'0' lucid
zinit light mollifier/cd-gitroot

zinit ice wait'0' lucid
zinit light peterhurford/up.zsh

zinit ice wait'0' lucid
zinit light Tarrasch/zsh-bd

zinit ice wait'0' lucid
zinit light jocelynmallon/zshmarks


#--------------------------------#
# git
#--------------------------------#
# zinit ice wait'!0' lucid # -> using as a alias in gitconfig
zinit light caarlos0/zsh-git-sync


#--------------------------------#
# fzf
#--------------------------------#
zinit ice wait'0b' lucid from"gh-r" as"program" atload"source $ZHOMEDIR/rc/pluginconfig/fzf_atload.zsh"
zinit load junegunn/fzf-bin
zinit ice wait'0a' lucid
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
zinit ice wait'1a' lucid atload"source $ZHOMEDIR/rc/pluginconfig/fzf_completion.zsh_atload.zsh"
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh

zinit ice wait'1' lucid pick"fzf-extras.zsh" atload"source $ZHOMEDIR/rc/pluginconfig/fzf-extras_atload.zsh"
zinit light atweiden/fzf-extras # fzf

# after zsh-autocomplete & fzf_completion.zsh
zinit ice wait'1c' lucid atinit"source $ZHOMEDIR/rc/pluginconfig/fz_atinit.zsh"
zinit light changyuheng/fz

zinit ice wait'0c' lucid pick"fzf-finder.plugin.zsh" atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-plugin-fzf-finder_atinit.zsh"
zinit light leophys/zsh-plugin-fzf-finder

zinit ice wait'0c' lucid atinit"source $ZHOMEDIR/rc/pluginconfig/fzf-mark_atinit.zsh"
zinit light urbainvaes/fzf-marks

zinit ice wait'1c' lucid atinit"source $ZHOMEDIR/rc/pluginconfig/fzf-zsh-completions_atinit.zsh"
zinit light chitoku-k/fzf-zsh-completions

zinit ice wait'2' lucid atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-fzf-widgets_atinit.zsh"
zinit light amaya382/zsh-fzf-widgets

# after load fzf-zsh-completions
zinit ice wait'1' lucid atinit"FZF_PREVIEW_DISABLE_DEFAULT_BINDKEY=1" atload"source $ZHOMEDIR/rc/pluginconfig/fzf-preview_atload.zsh"
zinit light yuki-ycino/fzf-preview.zsh


#--------------------------------#
# extension
#--------------------------------#
zinit ice wait'1' lucid atload"source $ZHOMEDIR/rc/pluginconfig/emoji-cli_atload.zsh"
zinit light b4b4r07/emoji-cli

zinit ice wait'!0' lucid
zinit light t413/zsh-background-notify


#--------------------------------#
# enhancive command
#--------------------------------#
zinit ice wait'1' lucid from"gh-r" as"program" mv"exa* -> exa" atload"alias ls=exa"
zinit light ogham/exa

zinit ice wait'1' lucid from"gh-r" as'program' pick'ripgrep*/rg' blockf nocompletions atclone'chown -R $(id -nu):$(id -ng) .; zinit creinstall -q BurntSushi/ripgrep' atpull'%atclone'
zinit light BurntSushi/ripgrep

zinit ice wait'1' lucid from"gh-r" as'program' pick'fd*/fd' blockf nocompletions atclone'chown -R $(id -nu):$(id -ng) .; zinit creinstall -q sharkdp/fd' atpull'%atclone'
zinit light sharkdp/fd

zinit ice wait'1' lucid from"gh-r" as"program" pick"bat/bat" mv"bat* -> bat"
zinit light sharkdp/bat

zinit ice wait'1' lucid from"gh-r" as"program" pick"rip*/rip" atload"alias rm=rip"
zinit light nivekuil/rip

zinit ice wait'1' lucid from"gh-r" as"program" pick"tldr"
zinit light dbrgn/tealdeer
zinit ice wait'1' lucid as"completion" mv'zsh_tealdeer -> _tldr'
zinit snippet https://github.com/dbrgn/tealdeer/blob/master/zsh_tealdeer

zinit ice wait'1' lucid from"gh-r" as"program" bpick'*lnx*'
zinit light dalance/procs


#--------------------------------#
# program
#--------------------------------#

# neovim
zinit ice wait'0' lucid from'gh-r' ver'nightly' as'program' pick'nvim*/bin/nvim' atclone'echo "" > ._zinit/is_release' atpull'%atclone' run-atpull
zinit light neovim/neovim
zinit id-as=node as='monitor|command' extract nocompletions \
    dlink=node-v'%VERSION%'-linux-x64.tar.gz \
    pick'node*/bin/*' \
    for https://nodejs.org/download/release/latest/

# tmux
if ldconfig -p | grep -q 'libevent-' && ldconfig -p | grep -q 'libncurses'; then
  zinit ice wait'0' from"gh-r" as"program" bpick"tmux-*.tar.gz" atclone"cd tmux*/; ./configure; make" atpull"%atclone" pick"*/tmux"
  zinit light tmux/tmux
elif builtin command -v tmux > /dev/null 2>&1 && test $(echo "$(tmux -V | cut -d' ' -f2) <= "2.5"" | tr -d '[:alpha:]' | bc) -eq 1; then
  zinit ice wait'0' lucid from'gh-r' as'program' bpick'*AppImage*' mv'tmux* -> tmux' pick'tmux'
  zinit light tmux/tmux
fi

# diff #
zinit ice wait'1' lucid from"gh-r" as"program" pick"delta*/delta"
zinit light dandavison/delta

# translation #
zinit ice wait'1' lucid
zinit light soimort/translate-shell

zinit ice wait'1' lucid from"gh-r" as"program" atload"source $ZHOMEDIR/rc/pluginconfig/nextword_atload.zsh"
zinit light high-moctane/nextword

# env #
zinit ice wait'1' lucid from"gh-r" as"program" mv"direnv* -> direnv" atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' pick"direnv"
zinit light direnv/direnv

zinit ice wait'1' lucid pick"asdf.sh"
zinit light asdf-vm/asdf

# GitHub #
zinit ice wait'1' lucid from"gh-r" as"program" pick"ghq*/ghq" atload"source $ZHOMEDIR/rc/pluginconfig/ghq_atload.zsh"
zinit light x-motemen/ghq

zinit ice wait'1' lucid from"gh-r" as"program" pick"ghg*/ghg"
zinit light Songmu/ghg

zinit ice wait'1' lucid from"gh-r" as'program' bpick'*linux_arm64.tar.gz' pick'**/gh'
zinit light cli/cli

zinit ice wait'1' lucid from"gh-r" as"program" mv"hub-*/bin/hub -> hub" pick"hub" atload"source $ZHOMEDIR/rc/pluginconfig/hub_atload.zsh"
zinit load github/hub

# snippet
[[ $- == *i* ]] && stty -ixon
zinit ice wait'1' lucid from"gh-r" as"program" pick"pet" bpick'*linux_amd64.tar.gz' blockf nocompletions atclone'chown -R $(id -nu):$(id -ng) .; zinit creinstall -q knqyf263/pet' atpull'%atclone' atload"source $ZHOMEDIR/rc/pluginconfig/pet_atload.zsh"

zinit load knqyf263/pet

# etc #
zinit ice wait'1' lucid as"program" pick"emojify"
zinit light mrowa44/emojify


#==============================================================#
# my plugins
#==============================================================#
zinit ice wait'1' lucid atload"source $ZHOMEDIR/rc/pluginconfig/mru.zsh_atload.zsh"
zinit light "$HOME/.zsh/rc/myplugins/mru.zsh"


#==============================================================#
# local plugins
#==============================================================#
[ -f "$HOME/.zshrc.plugin.local" ] && source "$HOME/.zshrc.plugin.local"


#==============================================================#
# old plugins
#==============================================================#
#
# -> marlonrichert/zsh-autocomplete
#zinit ice wait'!0b' lucid ver:pu atload"source $ZHOMEDIR/rc/pluginconfig/auto-fu.zsh_atload.zsh"
#zinit light hchbaw/auto-fu.zsh
#zinit ice wait'1' lucid
#zinit light "$HOME/.zsh/rc/myplugins/snippets.zsh"
# Not compatible with auto-fu
#zinit ice wait'0c' lucid atinit"source $ZHOMEDIR/rc/pluginconfig/fzf-ab_atload.zsh"
#zinit light Aloxaf/fzf-tab
# use snippet
#zinit ice wait'0a' lucid id-as"junegunn/fzf_completions" pick"/dev/null" multisrc"shell/{completion,key-bindings}.zsh"
#zinit light junegunn/fzf
# -> rip
#zinit ice wait'1' lucid from"gh-r" as"program" pick"gomi"
#zinit light b4b4r07/gomi
# -> exa
#zinit ice wait'0' lucid
#zinit light supercrabtree/k # ls
# -> powerlevel10k
# Too slow on ssh
# zinit ice wait'!0' lucid atload"source $ZHOMEDIR/rc/pluginconfig/zsh-command-time_atload.zsh"
# zinit light popstas/zsh-command-time
# fz
#FZFZ_RECENT_DIRS_TOOL=zshz
#zinit ice wait'!0' lucid as"program" pick:"fzf-z.plugin.zsh"
#zinit light andrewferrier/fzf-z
# fasd Not updated recently
#zinit ice pick'fasd'
#zinit light clvv/fasd atload'eval "$(fasd --init auto)"'
# asdf
#zinit ice wait'!0' lucid as"program" pick:"bin/anyenv" if"[[ -d "$HOME/.config/anyenv/anyenv-install" ]]" atload'eval "$(anyenv init -)"'
#zinit light anyenv/anyenv
# don't maintain
# zinit ice pick"*.sh" atinit"source $ZHOMEDIR/rc/pluginconfig/z_atinit.zsh"
# zinit light rupa/z
# git-prompt
# zinit ice lucid wait"0" atload"source $ZHOMEDIR/rc/pluginconfig/zsh-async_atload.zsh && set_async"
# zinit light mafredri/zsh-async

# don't use
# zinit ice wait'1' lucid atload"alias rm=gomi"
# zinit light b4b4r07/zsh-gomi
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



#==============================================================#
## Setup zinit                                                ##
#==============================================================#
if [ -z "$ZPLG_HOME" ]; then
  ZPLG_HOME="$ZDATADIR/zinit"
fi

if ! test -d "$ZPLG_HOME"; then
  mkdir -p "$ZPLG_HOME"
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
  @zinit-zsh/z-a-readurl
  #@zinit-zsh/z-a-bin-gem-node
  #@zinit-zsh/z-a-patch-dl \
  #@zinit-zsh/z-a-unscope \
  #@zinit-zsh/z-a-default-ice \
  #@zinit-zsh/z-a-submods
  #@zinit-zsh/z-a-man # -> require gem


#--------------------------------#
# completion
#--------------------------------#
zinit wait'0b' lucid \
  atload"source $ZHOMEDIR/rc/pluginconfig/zsh-autosuggestions_atload.zsh" \
  light-mode for @zsh-users/zsh-autosuggestions

zinit wait'0a' lucid \
  atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-autocomplete_atinit.zsh" \
  atload"source $ZHOMEDIR/rc/pluginconfig/zsh-autocomplete_atload.zsh" \
  light-mode for @marlonrichert/zsh-autocomplete

zinit wait'0b' lucid as"completion" \
  atload"source $ZHOMEDIR/rc/pluginconfig/zsh-completions_atload.zsh" \
  light-mode for @zsh-users/zsh-completions


#--------------------------------#
# prompt
#--------------------------------#
# -> gitstatus(powerlevel10k)
# git_version=$(git --version | head -n1 | cut -d" " -f3)
# if [[ "$(version3 "$git_version")" -ge "$(version3 "2.11.0")" ]]; then
#   zinit ice lucid atload"source $ZHOMEDIR/rc/pluginconfig/git-prompt_atload.zsh"
#   zinit light woefe/git-prompt.zsh
# else
#   zinit ice lucid atload"source $ZHOMEDIR/rc/pluginconfig/zsh-git-prompt_atload.zsh"
#   zinit light olivierverdier/zsh-git-prompt
# fi

zinit wait'0a' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
  light-mode for @zdharma/fast-syntax-highlighting

PROMPT="%~"$'\n'"> "
zinit wait'!0b' lucid depth=1 \
  atload"source $ZHOMEDIR/rc/pluginconfig/powerlevel10k_atload.zsh" \
  light-mode for @romkatv/powerlevel10k


#--------------------------------#
# history
#--------------------------------#
zinit wait'1' lucid \
  if"(( ${ZSH_VERSION%%.*} > 4.4))" \
  light-mode for @zsh-users/zsh-history-substring-search

zinit wait'2' lucid \
  light-mode for @larkery/zsh-histdb

zinit wait'2' lucid \
  atinit"source $ZHOMEDIR/rc/pluginconfig/per-directory-history.zsh" \
  atload"_per-directory-history-set-global-history" \
  light-mode for @CyberShadow/per-directory-history
# https://github.com/jimhester/per-directory-history/issues/21
# https://github.com/jimhester/per-directory-history/issues/27
#  @jimhester/per-directory-history


#--------------------------------#
# alias
#--------------------------------#
zinit wait'0' lucid \
  light-mode for @unixorn/git-extra-commands

zinit wait'0a' lucid \
  atload"source $ZHOMEDIR/rc/pluginconfig/zsh-abbrev-alias_atinit.zsh" \
  light-mode for @momo-lab/zsh-abbrev-alias
# do not execute eval & do not map ~~
# zinit wait'!0a' lucid \
#   atload"source $ZHOMEDIR/rc/pluginconfig/zsh-abbr_atinit.zsh" \
#   light-mode for @olets/zsh-abbr


#--------------------------------#
# environment variable
#--------------------------------#
zinit wait'0' lucid \
  light-mode for @Tarrasch/zsh-autoenv


#--------------------------------#
# improve cd
#--------------------------------#
# zinit wait'1' lucid \
#   atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-z_atinit.zsh" \
#   light-mode for @agkozak/zsh-z
zinit wait'1' lucid \
  from"gh-r" as"program" pick"zoxide-*/zoxide" \
  atload"source $ZHOMEDIR/rc/pluginconfig/zoxide_atload.zsh" \
  light-mode for @ajeetdsouza/zoxide

zinit wait'1' lucid \
  light-mode for @mollifier/cd-gitroot

zinit wait'1' lucid \
  light-mode for @peterhurford/up.zsh

zinit wait'1' lucid \
  light-mode for @Tarrasch/zsh-bd

zinit wait'1' lucid \
  light-mode for @jocelynmallon/zshmarks


#--------------------------------#
# git
#--------------------------------#
zinit wait'2' lucid \
  light-mode for @caarlos0/zsh-git-sync


#--------------------------------#
# fzf
#--------------------------------#
zinit wait'0b' lucid \
  from"gh-r" as"program" \
  atload"source $ZHOMEDIR/rc/pluginconfig/fzf_atload.zsh" \
  for @junegunn/fzf
zinit ice wait'0a' lucid
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
zinit ice wait'1a' lucid atload"source $ZHOMEDIR/rc/pluginconfig/fzf_completion.zsh_atload.zsh"
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
zinit ice wait'0a' lucid as"program"
zinit snippet https://github.com/junegunn/fzf/blob/master/bin/fzf-tmux

zinit wait'1' lucid \
  pick"fzf-extras.zsh" \
  atload"source $ZHOMEDIR/rc/pluginconfig/fzf-extras_atload.zsh" \
  light-mode for @atweiden/fzf-extras # fzf

# after zsh-autocomplete & fzf_completion.zsh
#zinit wait'1c' lucid \
#  atinit"source $ZHOMEDIR/rc/pluginconfig/fz_atinit.zsh" \
#  light-mode for @changyuheng/fz

zinit wait'0c' lucid \
  pick"fzf-finder.plugin.zsh" \
  atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-plugin-fzf-finder_atinit.zsh" \
  light-mode for @leophys/zsh-plugin-fzf-finder

zinit wait'0c' lucid \
  atinit"source $ZHOMEDIR/rc/pluginconfig/fzf-mark_atinit.zsh" \
  light-mode for @urbainvaes/fzf-marks

zinit wait'1c' lucid \
  atinit"source $ZHOMEDIR/rc/pluginconfig/fzf-zsh-completions_atinit.zsh" \
  light-mode for @chitoku-k/fzf-zsh-completions

zinit wait'2' lucid \
  atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-fzf-widgets_atinit.zsh" \
  light-mode for @amaya382/zsh-fzf-widgets

# zinit wait'2' lucid \
#   from"gh-r" as"program" \
#   atload"source $ZHOMEDIR/rc/pluginconfig/pmy_atload.zsh" \
#   for @relastle/pmy

zinit wait'2' lucid blockf depth"1" \
  atclone'deno cache --no-check ./bin/zeno' \
  atpull'%atclone' \
  atinit"source $ZHOMEDIR/rc/pluginconfig/zeno_atinit.zsh" \
  atload"source $ZHOMEDIR/rc/pluginconfig/zeno_atload.zsh" \
  for @yuki-yano/zeno.zsh


#--------------------------------#
# extension
#--------------------------------#
zinit wait'1' lucid \
  atload"source $ZHOMEDIR/rc/pluginconfig/emoji-cli_atload.zsh" \
  light-mode for @b4b4r07/emoji-cli

zinit wait'0' lucid \
  light-mode for @t413/zsh-background-notify

zinit wait'0' lucid \
  light-mode for @mafredri/zsh-async

zinit wait'0' lucid \
  atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-completion-generator_atinit.zsh" \
  light-mode for @RobSis/zsh-completion-generator

# cannot be disabled bindkey '^T' zsh-startify
#zplugin wait'2' lucid \
#  light-mode for @zdharma/zsh-startify
# don't like this color
# zinit pack for ls_colors
# zinit pack for dircolors-material

#--------------------------------#
# enhancive command
#--------------------------------#
zinit wait'1' lucid \
  from"gh-r" as"program" pick"bin/exa" \
  atload"source $ZHOMEDIR/rc/pluginconfig/exa_atload.zsh" \
  light-mode for @ogham/exa

zinit wait'1' lucid blockf nocompletions \
  from"gh-r" as'program' pick'ripgrep*/rg' \
  atclone'chown -R $(id -nu):$(id -ng) .; zinit creinstall -q BurntSushi/ripgrep' \
  atpull'%atclone' \
  light-mode for @BurntSushi/ripgrep

zinit wait'1' lucid blockf nocompletions \
  from"gh-r" as'program' cp"fd-*/autocomplete/_fd -> _fd" pick'fd*/fd' \
  atclone'chown -R $(id -nu):$(id -ng) .; zinit creinstall -q sharkdp/fd' \
  atpull'%atclone' \
  light-mode for @sharkdp/fd

zinit wait'1' lucid \
  from"gh-r" as"program" cp"bat/autocomplete/bat.zsh -> _bat" pick"bat*/bat" \
  atload"export BAT_THEME='gruvbox-dark'; alias cat=bat" \
  light-mode for @sharkdp/bat

zinit wait'1' lucid \
  from"gh-r" as"program" pick"rip*/rip" \
  atload"alias rm='rip --graveyard ~/.local/share/Trash'" \
  light-mode for @nivekuil/rip

zinit wait'1' lucid \
  from"gh-r" as"program" pick"tldr" \
  light-mode for @dbrgn/tealdeer
zinit ice wait'1' lucid as"completion" mv'zsh_tealdeer -> _tldr'
zinit snippet https://github.com/dbrgn/tealdeer/blob/master/zsh_tealdeer

zinit wait'1' lucid \
  from"gh-r" as"program" bpick'*lnx*' \
  light-mode for @dalance/procs

zinit wait'1' lucid \
  from"gh-r" as"program" pick"delta*/delta" \
  light-mode for @dandavison/delta

zinit wait'1' lucid \
  from"gh-r" as"program" pick"mmv*/mmv" \
  light-mode for @itchyny/mmv


#--------------------------------#
# program
#--------------------------------#
# zsh
if [[ "${ZSH_INSTALL}" == "true" ]]; then
  # zinit pack for zsh
  if builtin command -v make > /dev/null 2>&1; then
      zinit id-as=zsh as"null" lucid depth=1 \
        atclone"./.preconfig; m {hi}Building Zsh...{rst}; \
          CPPFLAGS='-I/usr/include -I/usr/local/include' CFLAGS='-g -O2 -Wall' LDFLAGS='-L/usr/libs -L/usr/local/libs' \
          ./configure --prefix=\"$ZPFX\" \
            --enable-multibyte \
            --enable-function-subdirs \
            --with-tcsetpgrp \
            --enable-pcre \
            --enable-cap \
            --enable-zsh-secure-free \
            >/dev/null && \
          { type yodl &>/dev/null || \
            { m -u2 {warn}WARNING{ehi}:{rst}{warn} No {cmd}yodl{warn}, manual pages will not be built.{rst}; ((0)); } && \
            { make install; ((1)); } || make install.bin install.fns install.modules } >/dev/null && \
          { type sudo &>/dev/null && sudo rm -f /bin/zsh && sudo cp -vf Src/zsh /bin/zsh; ((1)); } && \
            m {success}The build succeeded.{rst} || m {failure}The build failed.{rst}" \
        atpull"%atclone" nocompile countdown git \
        for @zsh-users/zsh
  fi
fi

# git
if builtin command -v make > /dev/null 2>&1; then
  zinit wait'0' lucid nocompile \
    id-as=git as='null|readurl' \
    mv"%ID% -> git.tar.gz" \
    atclone'ziextract --move --auto git.tar.gz && \
      make -j $[$(grep cpu.cores /proc/cpuinfo | sort -u | sed "s/[^0-9]//g") + 1] prefix=$ZPFX all install && \
      \rm -rf $ZINIT[SNIPPETS_DIR]/git/*' \
    atpull"%atclone" \
    dlink='/git/git/archive/refs/tags/v%VERSION%.tar.gz' \
    for https://github.com/git/git/releases/
fi

# neovim
zinit wait'0' lucid nocompletions \
  from'gh-r' ver'nightly' as'program' pick'nvim*/bin/nvim' \
  atclone'echo "" > ._zinit/is_release' \
  atpull'%atclone' \
  run-atpull \
  atload"source $ZHOMEDIR/rc/pluginconfig/neovim_atload.zsh" \
  light-mode for @neovim/neovim

# node (for coc.nvim)
zinit wait'0' lucid id-as=node as='readurl|command' \
  nocompletions nocompile extract \
  pick'node*/bin/*' \
  dlink='node-v%VERSION%-linux-x64.tar.gz' \
  for https://nodejs.org/download/release/latest/

# tmux
if ldconfig -p | grep -q 'libevent-' && ldconfig -p | grep -q 'libncurses'; then
  zinit wait'0' lucid \
    from"gh-r" as"program" bpick"tmux-*.tar.gz" pick"*/tmux" \
    atclone"cd tmux*/; ./configure; make" \
    atpull"%atclone" \
    light-mode for @tmux/tmux
elif builtin command -v tmux > /dev/null 2>&1 && test $(echo "$(tmux -V | cut -d' ' -f2) <= "2.5"" | tr -d '[:alpha:]' | bc) -eq 1; then
  zinit wait'0' lucid \
    from'gh-r' as'program' bpick'*AppImage*' mv'tmux* -> tmux' pick'tmux' \
    light-mode for @tmux/tmux
fi

zinit wait'1' lucid \
  as"program" \
  pick'bin/*' \
  light-mode for @greymd/tmux-xpanes

# translation #
zinit wait'1' lucid \
  light-mode for @soimort/translate-shell

zinit wait'1' lucid \
  atclone"python setup.py install --prefix=${ZPLG_HOME}/polaris/" \
  atpull'%atclone' \
  light-mode for @nidhaloff/deep-translator

zinit wait'1' lucid \
  from"gh-r" as"program" \
  atload"source $ZHOMEDIR/rc/pluginconfig/nextword_atload.zsh" \
  light-mode for @high-moctane/nextword

# env #
zinit wait'1' lucid \
  from"gh-r" as"program" pick"direnv" \
  atclone'./direnv hook zsh > zhook.zsh' \
  atpull'%atclone' \
  light-mode for @direnv/direnv

zinit wait'1' lucid \
  atinit"source $ZHOMEDIR/rc/pluginconfig/asdf_atinit.zsh" \
  pick"asdf.sh" \
  light-mode for @asdf-vm/asdf

# GitHub #
zinit wait'1' lucid \
  from"gh-r" as"program" pick"ghq*/ghq" \
  atload"source $ZHOMEDIR/rc/pluginconfig/ghq_atload.zsh" \
  light-mode for @x-motemen/ghq

zinit wait'1' lucid \
  from"gh-r" as"program" pick"ghg*/ghg" \
  light-mode for @Songmu/ghg

zinit wait'1' lucid \
  from"gh-r" as'program' bpick'*linux_*.tar.gz' pick'gh*/**/gh' \
  atload"source $ZHOMEDIR/rc/pluginconfig/gh_atload.zsh" \
  light-mode for @cli/cli

zinit wait'1' lucid \
  from"gh-r" as"program" cp"hub-*/etc/hub.zsh_completion -> _hub" pick"hub-*/bin/hub" \
  atload"source $ZHOMEDIR/rc/pluginconfig/hub_atload.zsh" \
  for @github/hub

# snippet
[[ $- == *i* ]] && stty -ixon
zinit wait'1' lucid blockf nocompletions \
  from"gh-r" as"program" pick"pet" bpick'*linux_amd64.tar.gz' \
  atclone'chown -R $(id -nu):$(id -ng) .; zinit creinstall -q knqyf263/pet' \
  atpull'%atclone' \
  atload"source $ZHOMEDIR/rc/pluginconfig/pet_atload.zsh" \
  for @knqyf263/pet

# etc #
zinit wait'1' lucid \
  as"program" pick"emojify" \
  light-mode for @mrowa44/emojify


#==============================================================#
# my plugins
#==============================================================#
zinit wait'1' lucid \
  atload"source $ZHOMEDIR/rc/pluginconfig/mru.zsh_atload.zsh" \
  light-mode for "$ZHOMEDIR/rc/myplugins/mru.zsh/"
zinit wait'2' lucid \
  light-mode for "$ZHOMEDIR/rc/myplugins/coc-project.zsh/"


#==============================================================#
# Analytics
#==============================================================#
if [[ "${DISABLE_WAKATIME}" == "true" ]]; then
  zinit wait'2' lucid \
    atpull'pip install wakatime' \
    light-mode for @sobolevn/wakatime-zsh-plugin
fi


#==============================================================#
# completion
#==============================================================#
zinit wait'2' lucid \
  atload"zicompinit; zicdreplay" \
  light-mode for "$ZHOMEDIR/rc/myplugins/command_config.zsh"


#==============================================================#
# local plugins
#==============================================================#
[ -f "$HOME/.zshrc.plugin.local" ] && source "$HOME/.zshrc.plugin.local"


#==============================================================#
# old plugins
#==============================================================#

# deprecated
## after load fzf-zsh-completions
#zinit wait'1' lucid \
#  atinit"FZF_PREVIEW_DISABLE_DEFAULT_BINDKEY=1" \
#  atload"source $ZHOMEDIR/rc/pluginconfig/fzf-preview_atload.zsh" \
#  light-mode for @yuki-ycino/fzf-preview.zsh
#zinit wait'2' lucid \
#  atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-cwd-history.zsh" \
#  light-mode for @ericfreese/zsh-cwd-history
## I like per-directory-history. But it includes bugs of share history
#zinit wait'2' lucid as"program" pick"*.plugin.zsh" \
#  atinit"source $ZHOMEDIR/rc/pluginconfig/zsh-directory-history.zsh" \
#  light-mode for @tymm/zsh-directory-history
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

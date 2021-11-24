typeset -g -A ASDF_LATEST_PLUGINS
ASDF_LATEST_PLUGINS=()

function install_by_asdf() {
  local name="$1"
  local version="$2"
  local url="$3"
  ASDF_LATEST_PLUGINS[${name}]=${version}
  if ! asdf list ${name} &> /dev/null; then
    asdf plugin add ${name} ${url}
    asdf install ${name} ${version}
    asdf global ${name} ${version}
  fi
}

function relink_completion() {
  local comp_filepath="$1"
  local target="$2"
  if [[ ! -e ${target} ]]; then
    ln -snf ${comp_filepath} ${target}
  fi
}

function update-asdf-to-latest() {
  asdf plugin update --all
  for name in ${(k)ASDF_LATEST_PLUGINS}; do
    echo -n "${name}: "
    if [[ $(asdf current ${name} | awk '{print $2}') == $(asdf latest ${name}) ]]; then
      echo "Already updated"
      continue
    fi
    asdf uninstall ${name}
    asdf install ${name} ${ASDF_LATEST_PLUGINS[${name}]}
    asdf global ${name} ${ASDF_LATEST_PLUGINS[${name}]}
    echo "Installed new ${name} version"
  done
  echo ""
  cat ~/.tool-versions
}

# performance is not good
# https://github.com/asdf-vm/asdf-nodejs/issues/46

#install_by_asdf tmux 3.3-rc

#install_by_asdf git latest

#install_by_asdf neovim nightly
#export EDITOR=nvim
#alias vi="$EDITOR"
#alias sv="sudo $EDITOR"
#alias v='nvim -c "RestoreSession"'

#install_by_asdf nodejs latest

#install_by_asdf ripgrep latest
#relink_completion "$(asdf where ripgrep)/complete/_rg" "${HOME}/.config/zsh/completions.local/_rg"

#install_by_asdf fd latest
#relink_completion "$(asdf where fd)/autocomplete/_fd" "${HOME}/.config/zsh/completions.local/_fd"

#install_by_asdf exa latest
#relink_completion "$(asdf where exa)/completions/exa.zsh" "${HOME}/.config/zsh/completions.local/_exa"
#alias ls="exa"; alias ll="exa -l -snew"

#install_by_asdf bat latest
#relink_completion "$(asdf where bat)/autocomplete/bat.zsh" "${HOME}/.config/zsh/completions.local/_bat"
#export BAT_THEME='gruvbox-dark'; alias cat=bat

#install_by_asdf delta latest

#install_by_asdf github-cli latest


function install_by_asdf() {
  local name="$1"
  local version="$2"
  local url="$3"
  if ! asdf list ${name} &> /dev/null; then
    asdf plugin-add ${name} ${url}
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

install_by_asdf tmux latest
install_by_asdf git latest
install_by_asdf neovim nightly
install_by_asdf nodejs latest

install_by_asdf ripgrep latest
relink_completion "$(asdf where ripgrep)/complete/_rg" "${HOME}/.config/zsh/completions.local/_rg"

install_by_asdf fd latest
relink_completion "$(asdf where fd)/autocomplete/_fd" "${HOME}/.config/zsh/completions.local/_fd"

install_by_asdf exa latest
relink_completion "$(asdf where exa)/completions/exa.zsh" "${HOME}/.config/zsh/completions.local/_exa"
alias ls="exa"; alias ll="exa -l -snew"

install_by_asdf bat latest
relink_completion "$(asdf where bat)/autocomplete/bat.zsh" "${HOME}/.config/zsh/completions.local/_bat"
export BAT_THEME='gruvbox-dark'; alias cat=bat

install_by_asdf delta latest
install_by_asdf github-cli latest

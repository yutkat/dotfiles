#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

install_fzf_local() {
  echo "Installing fzf local..."
  echo ""
  local distro=`whichdistro`
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y ruby ruby-dev gem ncurses-dev
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y ruby ruby-devel rubygems ncurses-devel
  else
    :
  fi
  command cp $fzf_dir/fzf $fzf_dir/bin && \
    echo "export PATH=$PATH:$fzf_dir/bin" > $HOME/.fzf.zsh
}

install_fzf() {
  local fzf_dir="$HOME/.fzf"
  git_clone_or_fetch https://github.com/junegunn/fzf.git \
    $fzf_dir
  $fzf_dir/install --no-key-bindings --completion  --no-update-rc || \
    install_fzf_local
}

install_fzf

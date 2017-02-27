#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

install_tmux-powerline() {
  git_clone_or_fetch https://github.com/erikw/tmux-powerline.git \
    "$HOME/.tmux/tmux-powerline"
}

install_tmuxinator() {
  local distro=`whichdistro`
  if ! type tmuxinator > /dev/null 2>&1;then
    echo "Installing tmuxinator..."
    echo ""
    if [[ $distro == "debian" ]];then
      sudo apt-get install -y ruby ruby-dev
    elif [[ $distro == "redhat" ]];then
      sudo yum install -y ruby ruby-devel rubygems
    else
      :
    fi
    sudo gem install tmuxinator
    mkdir -p $HOME/.tmuxinator/completion
    curl https://raw.github.com/aziz/tmuxinator/master/completion/tmuxinator.zsh \
      -o $HOME/.tmuxinator/completion/tmuxinator.zsh
  fi
}


install_tmux-powerline
install_tmuxinator

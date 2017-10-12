#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

install_golang() {
  if type "go" > /dev/null 2>&1; then
    return
  fi
  echo "Installing golang..."
  echo ""
  local distro=`whichdistro`
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y golang
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y golang
  elif [[ $distro == "arch" ]];then
    sudo pacman -S --noconfirm golang
  else
    :
  fi
  mkdir_not_exist $HOME/go
  export GOPATH=$HOME/go
}

install_golang

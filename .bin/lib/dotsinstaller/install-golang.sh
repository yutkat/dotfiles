#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

function install_golang() {
  if builtin command -v "go" > /dev/null 2>&1; then
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
    sudo pacman -S --noconfirm --needed go-pie
  elif [[ $distro == "alpine" ]];then
    :
  else
    :
  fi
  mkdir_not_exist $HOME/go
  export GOPATH=$HOME/go
}

install_golang

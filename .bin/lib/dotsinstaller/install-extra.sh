#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

install_extra() {
  local distro=`whichdistro`
  if [[ $distro == "debian" ]];then
    :
  elif [[ $distro == "redhat" ]];then
    :
  elif [[ $distro == "arch" ]];then
    sudo pacman -S --noconfirm --needed noto-fonts-cjk chromium lightdm
  else
    :
  fi
}

install_extra

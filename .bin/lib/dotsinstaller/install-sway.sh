#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

function install_sway() {
  local distro
  distro=$(whichdistro)
  if [[ $distro == "debian" ]]; then
    :
  elif [[ $distro == "redhat" ]]; then
    :
  elif [[ $distro == "arch" ]]; then
    sudo pacman -S --noconfirm --needed sway xorg-server-xwayland
  elif [[ $distro == "alpine" ]]; then
    :
  fi
  (cd $(dirname "${BASH_SOURCE[0]:-$0}") && ~/.sway/scripts/mkconfig.sh)
}

install_sway

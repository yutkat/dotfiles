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
    sudo pacman -S --noconfirm --needed sysstat alsa-utils
    sudo pacman -S --noconfirm --needed fcitx-mozc fcitx-configtool fcitx-gtk3 fcitx-qt5
    sudo pacman -S --noconfirm --needed ttf-dejavu noto-fonts-emoji
  else
    :
  fi
}

install_extra

source $(dirname "${BASH_SOURCE[0]:-$0}")/setup-fcitx.sh
source $(dirname "${BASH_SOURCE[0]:-$0}")/setup-default-app.sh


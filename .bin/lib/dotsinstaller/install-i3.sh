#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

install_i3() {
  local distro=`whichdistro`
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y i3 feh
    sudo apt-get install -y i3blocks || true
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y i3 feh
  elif [[ $distro == "arch" ]];then
    sudo pacman -S --noconfirm --needed xorg-server xorg-xinit
    sudo pacman -S --noconfirm --needed lightdm lightdm-gtk-greeter
    sudo pacman -S --noconfirm --needed i3 feh i3status i3blocks
    sudo pacman -S --noconfirm --needed dmenu xorg-xprop
  fi
  (cd $(dirname "${BASH_SOURCE[0]:-$0}") && ~/.i3/scripts/mkconfig.sh)
}

setup_i3() {
  local distro=`whichdistro`
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y scrot
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y scrot || true
  elif [[ $distro == "arch" ]];then
    sudo pacman -S --noconfirm --needed scrot
    (cd /usr/share && sudo ln -snf /usr/lib/i3blocks/ .)
  fi
  if [ ! -d ${HOME}/Pictures/screenshots ];then
    mkdir -p ${HOME}/Pictures/screenshots
  fi
}

install_i3
setup_i3

source $(dirname "${BASH_SOURCE[0]:-$0}")/setup-default-app.sh


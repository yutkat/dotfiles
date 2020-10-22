#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

function install_i3() {
  local distro
  distro=$(whichdistro)
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y i3 feh rofi dunst
    sudo apt-get install -y i3blocks || true
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y i3 feh
  elif [[ $distro == "arch" ]];then
    sudo pacman -S --noconfirm --needed xorg-server xorg-xinit
    sudo pacman -S --noconfirm --needed lightdm lightdm-gtk-greeter
    sudo pacman -S --noconfirm --needed i3-gaps feh i3status i3blocks i3lock
    sudo pacman -S --noconfirm --needed dmenu xorg-xprop rofi dunst compton
    sudo pacman -S --noconfirm --needed xorg-xbacklight lm_sensors xclip
    sudo pacman -S --noconfirm --needed xautolock unclutter
  elif [[ $distro == "alpine" ]];then
    :
  fi
  (cd $(dirname "${BASH_SOURCE[0]:-$0}") && ~/.i3/scripts/mkconfig.sh)
}

function setup_i3() {
  local distro
  distro=$(whichdistro)
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y scrot
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y scrot || true
  elif [[ $distro == "arch" ]];then
    sudo pacman -S --noconfirm --needed scrot flameshot
    (cd /usr/share && sudo ln -snf /usr/lib/i3blocks/ .)
  elif [[ $distro == "alpine" ]];then
    :
  fi
  if [ ! -d ${HOME}/Pictures/screenshots ];then
    mkdir -p ${HOME}/Pictures/screenshots
  fi
}

function install_i3blocks_contrib() {
  git_clone_or_fetch https://github.com/vivien/i3blocks-contrib.git ~/.i3/scripts/blocks/i3blocks-contrib
}

install_i3
setup_i3
sudo python3 -m pip install -U i3ipc
install_i3blocks_contrib


#!/bin/bash

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
    sudo pacman -S --noconfirm --needed xautolock
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
    sudo pacman -S --noconfirm --needed scrot
    (cd /usr/share && sudo ln -snf /usr/lib/i3blocks/ .)
  elif [[ $distro == "alpine" ]];then
    :
  fi
  if [ ! -d ${HOME}/Pictures/screenshots ];then
    mkdir -p ${HOME}/Pictures/screenshots
  fi
}

function service-alt-tab() {
  local s_file
  s_file="/etc/systemd/system/focus-last@$(whoami).service"
  cat $HOME/.i3/systemd/focus-last@user.service | envsubst | sudo tee $s_file > /dev/null
  sudo systemctl enable $(basename $s_file)
}

install_i3
setup_i3
sudo pip install i3ipc
# service-alt-tab

source $(dirname "${BASH_SOURCE[0]:-$0}")/setup-default-app.sh
source $(dirname "${BASH_SOURCE[0]:-$0}")/install-font.sh


#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

setup_gnome_terminal_config() {
  if type gnome-terminal > /dev/null 2>&1;then
    if type dbus-launch > /dev/null 2>&1;then
      if type gsettings > /dev/null 2>&1;then
        $(dirname "${BASH_SOURCE[0]:-$0}")/gnome-terminal-config-restore.sh
      fi
    fi
  fi
}

install_i3() {
  local distro=`whichdistro`
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y i3 feh
    sudo apt-get install -y i3blocks || true
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y i3 feh
  elif [[ $distro == "arch" ]];then
    sudo pacman -S --noconfirm xorg-server xorg-xinit
    sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
    sudo pacman -S --noconfirm i3 feh i3status i3blocks
    sudo pacman -S --noconfirm dmenu
  fi
  (cd $(dirname "${BASH_SOURCE[0]:-$0}") && ../.i3/scripts/mkconfig.sh)
}

setup_i3() {
  local distro=`whichdistro`
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y gnome-terminal
    sudo apt-get install -y libglib2.0-bin dbus-x11 || true
    sudo apt-get install -y scrot
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y gnome-terminal
    sudo yum install -y glib2 dbus-x11 || true
    sudo yum install -y scrot || true
  elif [[ $distro == "arch" ]];then
    sudo pacman -S --noconfirm gnome-terminal
    sudo pacman -S --noconfirm scrot
  fi
  setup_gnome_terminal_config
  if [ ! -d ${HOME}/Pictures/screenshots ];then
    mkdir -p ${HOME}/Pictures/screenshots
  fi
}


install_i3
setup_i3

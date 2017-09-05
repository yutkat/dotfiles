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

setup_urxvt() {
  local distro=`whichdistro`
  if [[ $distro == "debian" ]];then
    sudo apt-get install -y rxvt-unicode-256color x11-xserver-utils
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y rxvt-unicode-256color
  elif [[ $distro == "arch" ]];then
    sudo pacman -S --noconfirm rxvt-unicode urxvt-perls
  fi
  xrdb -remove && xrdb -merge ~/.Xresources
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
    sudo apt-get install -y scrot
  elif [[ $distro == "redhat" ]];then
    sudo yum install -y scrot || true
  elif [[ $distro == "arch" ]];then
    sudo pacman -S --noconfirm scrot
    (cd /usr/share && sudo ln -s /usr/lib/i3blocks/ .)
  fi
  setup_urxvt
  if [ ! -d ${HOME}/Pictures/screenshots ];then
    mkdir -p ${HOME}/Pictures/screenshots
  fi
}


install_i3
setup_i3

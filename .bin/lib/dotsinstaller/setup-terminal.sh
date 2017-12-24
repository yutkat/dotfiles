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
    sudo pacman -S --noconfirm --needed rxvt-unicode urxvt-perls
  fi
  if [[ -v DISPLAY && -n "$DISPLAY" ]]; then
    xrdb -remove && xrdb -merge ~/.Xresources
  fi
}

setup_urxvt
source $(dirname "${BASH_SOURCE[0]:-$0}")/setup-default-app.sh



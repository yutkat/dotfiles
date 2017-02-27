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
  fi
  setup_gnome_terminal_config
  if [ ! -d ${HOME}/Pictures/screenshots ];then
    mkdir -p ${HOME}/Pictures/screenshots
  fi
}


install_i3
setup_i3

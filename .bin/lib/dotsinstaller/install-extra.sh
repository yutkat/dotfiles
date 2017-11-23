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
    sudo pacman -S --noconfirm --needed fcitx-mozc fcitx-configtool
  else
    :
  fi

  for list in "chromium" "firefox";do
    BROWSER=$(which $list 2> /dev/null)
    if [ $? -eq 0 ];then
      sudo ln -snf $BROWSER /usr/bin/x-www-browser
      break
    fi
  done
}

install_extra

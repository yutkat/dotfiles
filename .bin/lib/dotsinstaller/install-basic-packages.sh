#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

checkinstall zsh git vim tmux ctags bc curl wget xsel gawk python-pip unzip sqlite gettext procps nodejs

distro=`whichdistro`
if [[ $distro == "redhat" ]];then
  :
elif [[ $distro == "arch" ]];then
  sudo pacman -S --noconfirm --needed tar
elif [[ $distro == "alpine" ]];then
  :
else
  :
fi



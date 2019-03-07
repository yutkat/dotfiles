#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

checkinstall zsh git vim neovim tmux ctags bc curl wget xsel gawk python-pip unzip sqlite expect

distro=`whichdistro`
if [[ $distro == "redhat" ]];then
  sudo python3 -m pip install pynvim || true
elif [[ $distro == "arch" ]];then
  sudo pacman -S --noconfirm --needed tar
else
  sudo pip install pynvim
fi


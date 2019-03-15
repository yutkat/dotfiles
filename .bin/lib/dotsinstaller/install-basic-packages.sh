#!/bin/bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

checkinstall zsh git vim neovim tmux ctags bc curl wget xsel gawk python-pip unzip sqlite

distro=`whichdistro`
if [[ $distro == "redhat" ]];then
  sudo python3 -m pip install pynvim || true
elif [[ $distro == "arch" ]];then
  sudo pacman -S --noconfirm --needed tar
elif [[ $distro == "alpine" ]];then
  sudo apk add python3 gcc libc-dev procps perl ncurses coreutils python3-dev
  sudo python3 -m pip install pynvim
else
  sudo pip install pynvim
fi


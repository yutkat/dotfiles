#!/usr/bin/env bash

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

git_clone_or_fetch https://github.com/escape0707/fcitx5-adwaita-dark.git ~/.local/share/fcitx5/themes/adwaita-dark

#if [ -f ~/.xprofile ]; then
#  echo "ERROR: ~/.xprofile is exist"
#  exit 1
#fi
#
#{
#echo export GTK_IM_MODULE=fcitx
#echo export QT_IM_MODULE=fcitx
#echo export XMODIFIERS=@im=fcitx
#echo fcitx
#} >> ~/.xprofile

# fcitx > /dev/null 2>&1 || true
# if [ -f ~/.config/fcitx/config ]; then
#   sed -i -e 's/#InactivateKey=/InactivateKey=ESCAPE CTRL_[/g' ~/.config/fcitx/config
# else
#   print_error "Please execute fcitx"
#   exit 1
# fi

#!/bin/bash

if [ -f ~/.xprofile ]; then
  echo "ERROR: ~/.xprofile is exist"
  exit 1
fi

{
echo export GTK_IM_MODULE=fcitx
echo export QT_IM_MODULE=fcitx
echo export XMODIFIERS=@im=fcitx
echo fcitx
} >> ~/.xprofile


sed -i -e 's/#InactivateKey=/InactivateKey=ESCAPE CTRL_[/g' ~/.config/fcitx/config

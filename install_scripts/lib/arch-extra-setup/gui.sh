#!/usr/bin/env bash

sudo pacman -S --noconfirm --needed keepassxc mplayer smplayer imagemagick peek ffmpeg
sudo pacman -S --noconfirm --needed xorg-xhost
yay -S --noconfirm --needed i3-easyfocus-git wmfocus clipmenu light-git
if pacman -Qi rxvt-unicode >/dev/nul 2>&1; then
  yay -R --noconfirm rxvt-unicode || true
fi
if [[ $(basename "$(readlink "$(command -v x-terminal-emulator)")") == "urxvt" ]]; then
  yay -S --noconfirm --needed rxvt-unicode-truecolor-wide-glyphs
  #yay -S --noconfirm --needed urxvt-resize-font-git
  yay -S --noconfirm --needed fcitx5-skin-adwaita-dark
fi

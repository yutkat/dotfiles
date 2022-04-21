#!/usr/bin/env bash

sudo pacman -S --noconfirm --needed keepassxc mplayer smplayer imagemagick peek ffmpeg
sudo pacman -S --noconfirm --needed xorg-xhost ttf-font-awesome gnome-themes-extra
paru -S --noconfirm --needed i3-easyfocus-git wmfocus clipmenu
paru -S --noconfirm --needed adwaita-qt
if pacman -Qi rxvt-unicode >/dev/nul 2>&1; then
	paru -R --noconfirm rxvt-unicode || true
fi
if [[ $(basename "$(readlink "$(command -v x-terminal-emulator)")") == "urxvt" ]]; then
	paru -S --noconfirm --needed rxvt-unicode-truecolor-wide-glyphs
	#paru -S --noconfirm --needed urxvt-resize-font-git
	paru -S --noconfirm --needed fcitx5-skin-adwaita-dark
fi

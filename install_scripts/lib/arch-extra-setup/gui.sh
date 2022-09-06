#!/usr/bin/env bash

sudo pacman -S --noconfirm --needed keepassxc mplayer smplayer imagemagick peek ffmpeg
sudo pacman -S --noconfirm --needed xorg-xhost ttf-font-awesome gnome-themes-extra
sudo pacman -S --noconfirm --needed pipewire-pulse
paru -S --noconfirm --needed i3-easyfocus-git wmfocus clipmenu
paru -S --noconfirm --needed adwaita-qt
paru -S --noconfirm --needed fcitx5-skin-adwaita-dark
# flameshot on wayland https://github.com/flameshot-org/flameshot/blob/master/docs/Sway and wlroots support.md
paru -S --noconfirm --needed xdg-desktop-portal xdg-desktop-portal-wlr grim

#paru -S --noconfirm --needed hyprland-bin waybar-hyprland-git hyprpaper brightnessctl wlogout

#!/usr/bin/env bash

sudo pacman -S --noconfirm --needed keepassxc mplayer smplayer imagemagick peek ffmpeg copyq
sudo pacman -S --noconfirm --needed xorg-xhost ttf-font-awesome gnome-themes-extra xcursor-comix
sudo pacman -S --noconfirm --needed pipewire-pulse
#paru -S --noconfirm --needed i3-easyfocus-git
paru -S --noconfirm --needed wmfocus ulauncher-git
sudo pacman -S --noconfirm --needed copyq
systemctl --user enable --now ulauncher
sudo pacman -S --noconfirm --needed arc-gtk-theme kvantum
sudo pacman -S --noconfirm --needed fcitx5-nord
# flameshot on wayland https://github.com/flameshot-org/flameshot/blob/master/docs/Sway and wlroots support.md
paru -S --noconfirm --needed xdg-desktop-portal xdg-desktop-portal-wlr grim

# hyperland
paru -S --noconfirm --needed pyprland nwg-look-bin

#paru -S --noconfirm --needed hyprland-bin waybar-hyprland-git hyprpaper brightnessctl wlogout

if [ "$(lspci -k | grep -A 2 -E "(VGA|3D)" | grep AMD)" != "" ]; then
	sudo pacman -S --noconfirm --needed xf86-video-amdgpu vulkan-radeon
elif [ "$(lspci -k | grep -A 2 -E "(VGA|3D)" | grep Intel)" != "" ]; then
	sudo pacman -S --noconfirm --needed xf86-video-intel vulkan-intel
fi

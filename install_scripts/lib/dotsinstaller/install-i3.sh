#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

function install_i3() {
	local distro
	distro=$(whichdistro)
	if [[ $distro == "debian" ]]; then
		sudo apt-get install -y i3 feh rofi dunst
	elif [[ $distro == "redhat" ]]; then
		sudo yum install -y i3 feh
	elif [[ $distro == "arch" ]]; then
		sudo pacman -S --noconfirm --needed xorg-server xorg-xinit
		sudo pacman -S --noconfirm --needed lightdm lightdm-gtk-greeter
		sudo pacman -S --noconfirm --needed i3-gaps feh i3status-rust
		sudo pacman -S --noconfirm --needed dmenu xorg-xprop rofi dunst compton
		sudo pacman -S --noconfirm --needed xorg-xbacklight lm_sensors xclip
		sudo pacman -S --noconfirm --needed xautolock unclutter
	elif [[ $distro == "alpine" ]]; then
		:
	fi
}

function setup_i3() {
	local distro
	distro=$(whichdistro)
	if [[ $distro == "debian" ]]; then
		sudo apt-get install -y scrot
	elif [[ $distro == "redhat" ]]; then
		sudo yum install -y scrot || true
	elif [[ $distro == "arch" ]]; then
		sudo pacman -S --noconfirm --needed scrot flameshot
		# flameshot on wayland https://github.com/flameshot-org/flameshot/blob/master/docs/Sway and wlroots support.md
		paru -S --noconfirm --needed xdg-desktop-portal xdg-desktop-portal-wlr grim
	elif [[ $distro == "alpine" ]]; then
		:
	fi
	if [ ! -d ${HOME}/Pictures/screenshots ]; then
		mkdir -p ${HOME}/Pictures/screenshots
	fi
}

install_i3
setup_i3
sudo python3 -m pip install -U i3ipc

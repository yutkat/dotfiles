#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

function install_sway() {
	local distro
	distro=$(whichdistro)
	if [[ $distro == "debian" ]]; then
		:
	elif [[ $distro == "redhat" ]]; then
		:
	elif [[ $distro == "arch" ]]; then
		sudo pacman -S --noconfirm --needed sway xorg-server-xwayland waybar swaylock swayidle swaybg
		sudo pacman -S --noconfirm --needed pipewire xdg-desktop-portal xdg-desktop-portal-wlr
	elif [[ $distro == "alpine" ]]; then
		:
	fi
	(cd $(dirname "${BASH_SOURCE[0]:-$0}") && ~/.config/sway/scripts/mkconfig.sh)
}

install_sway

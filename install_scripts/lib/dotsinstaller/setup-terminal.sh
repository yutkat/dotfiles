#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

function setup_gnome_terminal_config() {
	if builtin command -v gnome-terminal >/dev/null 2>&1; then
		if builtin command -v dbus-launch >/dev/null 2>&1; then
			if builtin command -v gsettings >/dev/null 2>&1; then
				$(dirname "${BASH_SOURCE[0]:-$0}")/gnome-terminal-config-restore.sh
			fi
		fi
	fi
}

function setup_urxvt() {
	local distro
	distro=$(whichdistro)
	if [[ $distro == "debian" ]]; then
		sudo apt-get install -y rxvt-unicode-256color x11-xserver-utils
	elif [[ $distro == "redhat" ]]; then
		sudo yum install -y rxvt-unicode-256color
	elif [[ $distro == "arch" ]]; then
		sudo pacman -S --noconfirm --needed rxvt-unicode urxvt-perls
	elif [[ $distro == "alpine" ]]; then
		sudo apk add rxvt-unicode
	fi
	if [[ -v DISPLAY && -n "$DISPLAY" ]]; then
		xrdb -remove && xrdb -DHOME_ENV="$HOME" -merge ~/.config/X11/Xresources
	fi
}

function setup_alacritty() {
	local distro
	distro=$(whichdistro)
	if [[ $distro == "arch" ]]; then
		sudo pacman -S --noconfirm --needed alacritty
	elif [[ $distro == "alpine" ]]; then
		sudo apk add alacritty
	fi
}

function setup_wezterm() {
	local distro
	distro=$(whichdistro)
	if [[ $distro == "arch" ]]; then
		sudo pacman -S --noconfirm --needed wezterm
		sudo pacman -S --noconfirm --needed egl-wayland
	fi
}

# IME environment is not good
setup_wezterm
setup_alacritty
#setup_urxvt

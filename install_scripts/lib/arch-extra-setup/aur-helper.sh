#!/usr/bin/env bash

if ! builtin command -v paru >/dev/null 2>&1; then
	if [ ! -d /tmp/paru ]; then
		(cd /tmp && git clone https://aur.archlinux.org/paru-bin.git)
	fi
	sudo pacman -S --noconfirm --needed base-devel
	(cd /tmp/paru-bin && makepkg -si --noconfirm && paru -Syy)
fi

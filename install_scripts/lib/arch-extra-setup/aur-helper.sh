#!/usr/bin/env bash

if ! builtin command -v yay >/dev/null 2>&1; then
  if [ ! -d /tmp/yay ]; then
    (cd /tmp && git clone https://aur.archlinux.org/yay-bin.git)
  fi
  sudo pacman -S --noconfirm --needed base-devel
  (cd /tmp/yay-bin && makepkg -si --noconfirm && yay -Syy)
fi

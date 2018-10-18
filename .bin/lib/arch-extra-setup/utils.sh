#!/bin/bash
sudo pacman -S --noconfirm htop the_silver_searcher ripgrep mlocate unarchiver lesspipe sshpass bat fd ncdu tldr xrandr

if ! builtin command -v yay > /dev/null 2>&1; then
  if [ ! -d /tmp/yay ]; then
    (cd /tmp && git clone https://aur.archlinux.org/yay.git)
  fi
  (cd /tmp/yay && makepkg -si && yay -Syy)
fi

yay -S i3-easyfocus-git clipmenu urxvt-resize-font-git light-git


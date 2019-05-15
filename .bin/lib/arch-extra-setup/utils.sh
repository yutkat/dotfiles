#!/bin/bash
sudo pacman -S --noconfirm --needed htop the_silver_searcher ripgrep mlocate unarchiver lesspipe sshpass bat fd ncdu tldr xorg-xrandr pkgfile translate-shell

if ! builtin command -v yay > /dev/null 2>&1; then
  if [ ! -d /tmp/yay ]; then
    (cd /tmp && git clone https://aur.archlinux.org/yay.git)
  fi
  sudo pacman -S --noconfirm --needed base-devel
  (cd /tmp/yay && makepkg -si && yay -Syy)
fi

yay -S --noconfirm --needed i3-easyfocus-git clipmenu urxvt-resize-font-git light-git
sudo pacman -Rs neovim || true
if [[ -L /usr/local/bin/nvim ]]; then
  sudo rm /usr/local/bin/nvim || true
fi
yay -S --noconfirm --needed neovim-nightly


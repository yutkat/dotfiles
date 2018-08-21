#!/bin/bash
sudo pacman -S --noconfirm ripgrep mlocate urxvt-perls

if [ ! -d /tmp/yay ]; then
  (cd /tmp && git clone https://aur.archlinux.org/yay.git)
fi
(cd /tmp/yay && makepkg -si)

yay -S i3-easyfocus-git clipmenu urxvt-resize-font-git


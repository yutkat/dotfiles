#!/bin/bash
sudo pacman -S ripgrep mlocate urxvt-perls

(cd /tmp && git clone https://aur.archlinux.org/yay.git)
(cd /tmp/yay && makepkg -si)

sudo yay -S i3-easyfocus-git clipmenu urxvt-resize-font-git


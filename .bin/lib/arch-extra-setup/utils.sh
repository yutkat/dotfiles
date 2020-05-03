#!/usr/bin/env bash
sudo pacman -S --noconfirm --needed go htop the_silver_searcher mlocate unarchiver lesspipe sshpass xorg-xrandr pkgfile

if ! builtin command -v yay > /dev/null 2>&1; then
  if [ ! -d /tmp/yay ]; then
    (cd /tmp && git clone https://aur.archlinux.org/yay.git)
  fi
  sudo pacman -S --noconfirm --needed base-devel
  (cd /tmp/yay && makepkg -si --noconfirm && yay -Syy)
fi

yay -S --noconfirm --needed i3-easyfocus-git wmfocus clipmenu light-git
if ! builtin command -v urxvt > /dev/null 2>&1; then
  yay -S --noconfirm --needed urxvt-resize-font-git
fi

# sudo pacman -Rs --noconfirm neovim || true
# if [[ -L /usr/local/bin/nvim ]]; then
#   sudo rm /usr/local/bin/nvim || true
# fi
# yay -S --noconfirm --needed neovim-nightly


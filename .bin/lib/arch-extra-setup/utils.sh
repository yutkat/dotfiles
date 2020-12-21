#!/usr/bin/env bash
sudo pacman -S --noconfirm --needed go htop the_silver_searcher mlocate unarchiver lesspipe sshpass xorg-xrandr pkgfile

if ! builtin command -v yay >/dev/null 2>&1; then
  if [ ! -d /tmp/yay ]; then
    (cd /tmp && git clone https://aur.archlinux.org/yay-bin.git)
  fi
  sudo pacman -S --noconfirm --needed base-devel
  (cd /tmp/yay-bin && makepkg -si --noconfirm && yay -Syy)
fi

yay -S --noconfirm --needed i3-easyfocus-git wmfocus clipmenu light-git
if sudo pacman -Qi rxvt-unicode >/dev/nul 2>&1; then
  yay -R --noconfirm rxvt-unicode || true
fi
yay -S --noconfirm --needed rxvt-unicode-truecolor-wide-glyphs
#yay -S --noconfirm --needed urxvt-resize-font-git

yay -S --noconfirm --needed fcitx5-skin-adwaita-dark

# sudo pacman -Rs --noconfirm neovim || true
# if [[ -L /usr/local/bin/nvim ]]; then
#   sudo rm /usr/local/bin/nvim || true
# fi
# yay -S --noconfirm --needed neovim-nightly

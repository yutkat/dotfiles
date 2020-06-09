#!/usr/bin/env bash
sudo pacman -S --noconfirm --needed cups cups-pdf bind-tools pavucontrol
sudo systemctl enable systemd-timesyncd.service
sudo systemctl start systemd-timesyncd.service

yay -S --noconfirm --needed light-git

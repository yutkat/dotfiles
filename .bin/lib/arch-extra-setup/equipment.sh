#!/usr/bin/env bash
sudo pacman -S --noconfirm --needed cups cups-pdf bind-tools ntp
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service

yay -S --noconfirm --needed light-git

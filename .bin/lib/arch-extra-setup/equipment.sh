#!/bin/bash
sudo pacman -S --noconfirm cups cups-pdf bind-tools ntp
sudo systemd enable ntpd.service
sudo systemd start ntpd.service


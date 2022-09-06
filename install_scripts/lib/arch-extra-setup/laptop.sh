#!/usr/bin/env bash
sudo pacman -S --noconfirm --needed xf86-input-libinput xorg-xinput tpacpi-bat acpi_call
sudo pacman -S --noconfirm --needed tlp acpi
sudo systemctl enable tlp
sudo pacman -S --noconfirm --needed networkmanager network-manager-applet
sudo pacman -S --noconfirm --needed blueman
sudo systemctl start bluetooth
sudo systemctl enable bluetooth
sudo pacman -S --noconfirm --needed pasystray
sudo pacman -S --noconfirm --needed tlp fprintd sof-firmware

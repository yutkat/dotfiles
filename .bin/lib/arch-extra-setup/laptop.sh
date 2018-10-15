#!/bin/bash
sudo pacman -S --noconfirm xf86-input-synaptics tpacpi-bat acpi_call urxvt-perls
sudo pacman -S --noconfirm tlp acpi
sudo systemctl enable tlp
sudo pacman -S --noconfirm networkmanager network-manager-applet
sudo pacman -S --noconfirm blueberry
sudo systemctl start bluetooth
sudo systemctl enable bluetooth

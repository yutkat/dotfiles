#!/bin/bash
sudo pacman -S --noconfirm --needed xf86-input-synaptics tpacpi-bat acpi_call
sudo pacman -S --noconfirm --needed tlp acpi
sudo systemctl enable tlp
sudo pacman -S --noconfirm --needed networkmanager network-manager-applet
sudo pacman -S --noconfirm --needed blueberry
sudo systemctl start bluetooth
sudo systemctl enable bluetooth

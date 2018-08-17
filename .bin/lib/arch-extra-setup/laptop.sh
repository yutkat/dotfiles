#!/bin/bash
sudo pacman -S xf86-input-synaptics tpacpi-bat acpi_call urxvt-perls
sudo pacman -S tlp acpi
sudo systemctl enable tlp
sudo pacman -S networkmanager network-manager-applet

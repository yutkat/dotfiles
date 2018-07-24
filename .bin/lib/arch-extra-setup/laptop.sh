#!/bin/bash
sudo pacman -S xf86-input-synaptics tpacpi-bat acpi_call urxvt-perls
sudo pacman -S tlp
sudo systemctl enable tlp


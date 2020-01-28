#!/usr/bin/env bash
sudo pacman -S --noconfirm --needed xf86-input-libinput xorg-xinput tpacpi-bat acpi_call
sudo pacman -S --noconfirm --needed tlp acpi
sudo systemctl enable tlp
sudo pacman -S --noconfirm --needed networkmanager network-manager-applet
sudo pacman -S --noconfirm --needed blueberry
sudo systemctl start bluetooth
sudo systemctl enable bluetooth

# use xkbcomp
# function service-keymap() {
#   local s_file="/etc/systemd/system/loadkeys.service"
#   cat $HOME/.bin/lib/arch-extra-setup/systemd/loadkeys.service | envsubst | sudo tee $s_file > /dev/null
#   sudo systemctl enable $(basename $s_file)
# }
#
# service-keymap


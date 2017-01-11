#!/bin/bash

set -ue

## use gsettings
dbus-launch gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled false
dbus-launch gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
dbus-launch gsettings set org.gnome.Terminal.Legacy.Settings schema-version 'uint32 3'
dbus-launch gsettings set org.gnome.Terminal.Legacy.Settings shortcuts-enabled false

profile=$(dbus-launch gsettings get org.gnome.Terminal.ProfilesList default)
profile=${profile:1:-1}

dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ background-color 'rgb(0,0,0)'
dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ font 'Ubuntu Mono 9'
dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ foreground-color 'rgb(170,170,170)'
dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ palette "['rgb(0,0,0)', 'rgb(204,0,0)', 'rgb(78,154,6)', 'rgb(196,160,0)', 'rgb(52,101,164)', 'rgb(117,80,123)', 'rgb(6,152,154)', 'rgb(211,215,207)', 'rgb(85,87,83)', 'rgb(239,41,41)', 'rgb(138,226,52)', 'rgb(252,233,79)', 'rgb(114,159,207)', 'rgb(173,127,168)', 'rgb(52,226,226)', 'rgb(238,238,236)']"
dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ scroll-on-output false
dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ use-system-font false
dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ use-theme-colors false
#dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ use-theme-transparency false


## use dconf

#REPO_ROOT_DIR=$(builtin cd $(dirname "${BASH_SOURCE[0]:-$0}")/.. && pwd)
# backup
#dbus-launch dconf dump /org/gnome/terminal/ > gnome-terminal.conf

# restore
#dbus-launch dconf load /org/gnome/terminal/ < ${REPO_ROOT_DIR}/.i3/app-config/gnome-terminal.conf




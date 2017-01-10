#!/bin/bash

set -ue

REPO_ROOT_DIR=$(cd $(dirname "${BASH_SOURCE:-$0}")/.. && pwd)
# backup
#dbus-launch dconf dump /org/gnome/terminal/ > gnome-terminal.conf

# restore
dbus-launch dconf load /org/gnome/terminal/ < ${REPO_ROOT_DIR}/.i3/app-config/gnome-terminal.conf


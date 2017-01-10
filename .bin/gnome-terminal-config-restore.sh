#!/bin/bash

REPO_ROOT_DIR=$(cd $(dirname $0)/.. && pwd)

# backup
#dconf dump /org/gnome/terminal/ > gnome-terminal.conf

# restore
dconf load /org/gnome/terminal/ < ${REPO_ROOT_DIR}/.i3/app-config//gnome-terminal.conf


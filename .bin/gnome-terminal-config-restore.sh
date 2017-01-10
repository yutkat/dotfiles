#!/bin/bash

set -ue

REPO_ROOT_DIR=$(builtin cd $(dirname "${BASH_SOURCE[0]:-$0}")/.. && pwd)
echo "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
echo $(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
echo $REPO_ROOT_DIR
ls -lthra ..
ls -lthra $(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
echo "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
# backup
#dbus-launch dconf dump /org/gnome/terminal/ > gnome-terminal.conf

# restore
dbus-launch dconf load /org/gnome/terminal/ < ${REPO_ROOT_DIR}/.i3/app-config/gnome-terminal.conf


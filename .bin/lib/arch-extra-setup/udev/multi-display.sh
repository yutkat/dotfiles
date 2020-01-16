#!/usr/bin/env bash

CURRENT_DIR=$(dirname "${BASH_SOURCE[0]:-$0}")
sudo ln -snf $HOME/.i3/scripts/detect_displays.sh /usr/local/bin/detect_displays.sh
sudo cp $CURRENT_DIR/rules.d/99-keyboard-hotplug.rules /etc/udev/rules.d/

sudo udevadm control --reload-rules

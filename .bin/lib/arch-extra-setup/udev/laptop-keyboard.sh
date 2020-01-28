#!/usr/bin/env bash

CURRENT_DIR=$(dirname "${BASH_SOURCE[0]:-$0}")
sudo cp $CURRENT_DIR/hwdb.d/90-keyboard-layout.hwdb /etc/udev/hwdb.d/
sudo systemd-hwdb update


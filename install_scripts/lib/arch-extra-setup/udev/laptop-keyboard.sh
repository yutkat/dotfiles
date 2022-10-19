#!/usr/bin/env bash

function register_keymap() {
	local current_dir
	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	sudo cp $current_dir/hwdb.d/90-keyboard-layout.hwdb /etc/udev/hwdb.d/
	sudo systemd-hwdb update && sudo udevadm trigger
}

register_keymap

#!/usr/bin/env bash

function register_display_hotplug() {
	local current_dir
	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	sudo ln -snf $HOME/.config/i3/scripts/detect_displays.sh /usr/local/bin/detect_displays.sh
	sudo cp $current_dir/rules.d/95-monitor-hotplug.rules /etc/udev/rules.d/

	sudo udevadm control --reload-rules
}

register_display_hotplug

#!/usr/bin/env bash

function update_trackpoint_config() {
	if [ ! -d /etc/libinput ]; then
		mkdir /etc/libinput
	fi
	local current_dir
	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	sudo cp $current_dir/libinput/local-overrides.quirks /etc/libinput
}

update_trackpoint_config

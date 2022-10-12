##!/usr/bin/env bash

# https://github.com/f-viktor/dotfiles/blob/94e1fc9940840c0ba471087340447c631bb4d009/config/polybar/audio-output/audio-output.sh
function move_sinks_to_new_default {
	local DEFAULT_SINK=$1
	local SINK
	pactl list sink-inputs short | awk '{print $1}' | while read -r SINK; do
		pactl move-sink-input "$SINK" "$DEFAULT_SINK"
	done
}

function set_default_next_skip_unavailable {
	local inc=1
	local num_devices=$(pactl list sinks short | wc -l)

	while [[ $inc -le $num_devices ]]; do
		default_sink_index=$(($(pactl list sinks short | grep -no "$(pactl get-default-sink)" | grep -o '^[0-9]\+') - 1))
		next_sink_index=$((("$default_sink_index" + "$inc") % "$num_devices"))
		default_sink=${sink_arr[$next_sink_index]}
		pactl set-default-sink "$default_sink"

		check_sink_index=$(($(pactl list sinks short | grep -no "$(pactl get-default-sink)" | grep -o '^[0-9]\+') - 1))
		if [[ check_sink_index -ne default_sink_index ]]; then
			echo $default_sink
			return
		fi
		inc=$(($inc + 1))
	done
}

function set_default_playback_device_next {
	mapfile -t sink_arr < <(pactl list sinks short | awk '{print $2}')
	local default_sink=$(set_default_next_skip_unavailable)
	echo $default_sink
	move_sinks_to_new_default "$default_sink"
}

set_default_playback_device_next

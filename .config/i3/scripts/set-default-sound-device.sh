#!/usr/bin/env bash

# https://github.com/f-viktor/dotfiles/blob/94e1fc9940840c0ba471087340447c631bb4d009/config/polybar/audio-output/audio-output.sh
function move_sinks_to_new_default {
	local DEFAULT_SINK=$1
	local SINK
	pactl list sink-inputs short | awk '{print $1}' | while read -r SINK; do
		pactl move-sink-input "$SINK" "$DEFAULT_SINK"
	done
}

function set_default_playback_device_next {
	local inc=-1
	num_devices=$(pactl list sinks short | wc -l)
	mapfile -t sink_arr < <(pactl list sinks short | awk '{print $1}')
	default_sink_index=$(($(pactl list sinks short | grep -no "$(pactl get-default-sink)" | grep -o '^[0-9]\+') - 1))
	default_sink_index=$((("$default_sink_index" + "$num_devices" + "$inc") % "$num_devices"))
	default_sink=${sink_arr[$default_sink_index]}
	pactl set-default-sink "$default_sink"
	move_sinks_to_new_default "$default_sink"
}

set_default_playback_device_next

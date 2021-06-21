#!/usr/bin/env bash

# https://github.com/vivien/i3blocks-contrib/blob/0d1cbe08d5864b361682d0eee9724f9bbcbe9bd9/volume-pulseaudio/volume-pulseaudio#L89-L106
function move_sinks_to_new_default() {
  DEFAULT_SINK=$1
  pacmd list-sink-inputs | grep index: | grep -o '[0-9]\+' | while read -r SINK; do
    pacmd move-sink-input "$SINK" "$DEFAULT_SINK"
  done
}

function set_default_playback_device_next() {
  inc=1
  num_devices=$(pacmd list-sinks | grep -c index:)
  mapfile -t sink_arr < <(pacmd list-sinks | grep index: | grep -o '[0-9]\+')
  default_sink_index=$(($(pacmd list-sinks | grep index: | grep -no '*' | grep -o '^[0-9]\+') - 1))
  default_sink_index=$((("$default_sink_index" + "$num_devices" + "$inc") % "$num_devices"))
  default_sink=${sink_arr[$default_sink_index]}
  pacmd set-default-sink "$default_sink"
  move_sinks_to_new_default "$default_sink"
}

set_default_playback_device_next

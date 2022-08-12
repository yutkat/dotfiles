#!/usr/bin/env bash

exists_term=$(i3-msg -t get_tree | jq -r 'recurse(.nodes[];.nodes!=null).floating_nodes[]|select(.window_properties.class == "wezterm.scratchpad")' | wc -l)
if [[ "$exists_term" -eq 0 ]]; then
	i3-msg exec "~/.local/bin/x-terminal-emulator start --class 'wezterm.scratchpad'", floating enable, move scratchpad
	sleep 0.5
fi

declare -A rect
while IFS="=" read -r key value; do
	rect["$key"]="$value"
done < <(i3-msg -t get_tree | jq -r 'recurse(.nodes[];.nodes!=null)|select(.focused == true).rect|to_entries|map("\(.key)=\(.value|tostring)")|.[]')

width=$(echo "${rect['width']} / 1.1" | bc)
height=$(echo "${rect['height']} / 1.1" | bc)
x=$(echo "${rect['x']} + $width / 20" | bc)
y=$(echo "${rect['y']} + $height / 20" | bc)
i3-msg scratchpad show, resize set "$width" "$height", move absolute position "$x" "$y"

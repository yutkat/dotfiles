#!/usr/bin/env bash

function exists_scratchpad() {
	i3-msg -t get_tree | jq -r '..|.class?|select(.!=null)|select(. == "wezterm.scratchpad")' | wc -l
}

exists_term=$(exists_scratchpad)
if [[ "$exists_term" -eq 0 ]]; then
	i3-msg exec "$HOME/.local/bin/x-terminal-emulator start --class 'wezterm.scratchpad'"
	while [[ $exists_term -eq 0 ]]; do
		exists_term=$(exists_scratchpad)
		sleep 0.1
	done
	i3-msg '[class="^.*scratchpad$"] floating enable, move scratchpad'
fi

declare -A rect
rect['width']=800
rect['height']=800
rect['x']=1
rect['y']=1
while IFS="=" read -r key value; do
	rect["$key"]="$value"
done < <(i3-msg -t get_tree | jq -r 'recurse(.nodes[];.nodes!=null)|select(.focused == true).rect|to_entries|map("\(.key)=\(.value|tostring)")|.[]')

width=$(echo "${rect['width']} / 1.1" | bc)
height=$(echo "${rect['height']} / 1.1" | bc)
x=$(echo "${rect['x']} + $width / 20" | bc)
y=$(echo "${rect['y']} + $height / 20" | bc)

# focused=$(i3-msg -t get_tree | jq -r '.nodes[].nodes[].floating_nodes[]|select(.window_properties.class == "wezterm.scratchpad").focused')
# if [[ $focused == "true" ]]; then
# 	i3-msg scratchpad show
# else
#   i3-msg scratchpad show, resize set "$width" "$height", move absolute position "$x" "$y"
# fi
i3-msg scratchpad show, resize set "$width" "$height", move absolute position "$x" "$y"

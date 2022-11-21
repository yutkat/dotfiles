#!/usr/bin/env bash

function exists_scratchpad() {
	i3-msg -t get_tree | jq -r '..|.class?|select(.!=null)|select(. == "wezterm.scratchpad")' | wc -l
}

exists_term=$(exists_scratchpad)
if [[ "$exists_term" -eq 0 ]]; then
	i3-msg exec "$HOME/.local/bin/x-terminal-emulator start --class 'wezterm.scratchpad'"
	for i in $(seq 30); do
		exists_term=$(exists_scratchpad)
		if [[ $exists_term -ne 0 ]]; then
			break
		fi
		sleep 0.1
	done
	i3-msg '[class="^.*scratchpad$"] floating enable, move scratchpad'
fi

declare -A rect
rect['width']=$(i3-msg -t get_workspaces | jq -r '.[]|select(.focused == true).rect.width')
rect['height']=$(i3-msg -t get_workspaces | jq -r '.[]|select(.focused == true).rect.height')
rect['x']=$(i3-msg -t get_workspaces | jq -r '.[]|select(.focused == true).rect.x')
rect['y']=$(i3-msg -t get_workspaces | jq -r '.[]|select(.focused == true).rect.y')
current_workspace=$(i3-msg -t get_workspaces | jq -r '.[]|select(.focused == true).num')
while IFS="=" read -r key value; do
	rect["$key"]="$value"
done < <(i3-msg -t get_tree | jq -r '.nodes[].nodes[]|select(.type == "workspace")|select(.num == '$current_workspace')|recurse(.nodes[])|select(.name!=null)|select(.focused == false).rect|to_entries|map("\(.key)=\(.value|tostring)")|.[]')

width=$(echo "${rect['width']} / 1.1" | bc)
height=$(echo "${rect['height']} / 1.1" | bc)
x=$(echo "${rect['x']} + $width / 20" | bc)
y=$(echo "${rect['y']} + $height / 20" | bc)

visible=$(i3-msg -t get_tree | jq -r '.nodes[].nodes[].floating_nodes[]|select(.window_properties.class == "wezterm.scratchpad").visible')
if [[ $visible == "true" ]]; then
	i3-msg scratchpad show
else
	i3-msg scratchpad show, resize set "$width" "$height", move absolute position "$x" "$y"
fi

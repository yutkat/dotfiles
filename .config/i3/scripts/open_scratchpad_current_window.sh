#!/usr/bin/env bash

declare -A rect
while IFS="=" read -r key value; do
	rect["$key"]="$value"
done < <(i3-msg -t get_tree | jq -r 'recurse(.nodes[];.nodes!=null)|select(.focused == true).rect|to_entries|map("\(.key)=\(.value|tostring)")|.[]')

i3-msg scratchpad show

sleep 0.1

width=$(echo "${rect['width']} / 1.2" | bc)
height=$(echo "${rect['height']} / 1.2" | bc)
i3-msg resize set "$width" "$height"
x=$(echo "${rect['x']} + $width / 10" | bc)
y=$(echo "${rect['y']} + $height / 10" | bc)
i3-msg move absolute position "$x" "$y"

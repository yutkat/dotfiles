#!/usr/bin/env bash
trap 'kill $pid; exit 1' 1 2 3 15
last=

while true; do
	xprop -root -spy _NET_ACTIVE_WINDOW &
	pid=$!
	read -r line

	[[ -z "$last" ]] || i3-msg "[id=$last] mark _last"
	last=$(echo "$line" | awk -F' ' '{printf $NF}')
	echo "$last"
done

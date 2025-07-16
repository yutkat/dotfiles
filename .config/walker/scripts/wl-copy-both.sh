#!/usr/bin/env bash

if [ -p /dev/stdin ]; then
	input=$(cat)
	echo "$input" | wl-copy "$@"
	echo "$input" | wl-copy --primary "$@"
else
	wl-copy "$@"
	wl-copy --primary "$@"
fi

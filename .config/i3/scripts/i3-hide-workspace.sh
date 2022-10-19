#!/usr/bin/env bash
prev_workspace=$(i3-msg -t get_workspaces | tr '}' '\n' | grep '"focused":true' | tr , '\n' | grep '"num":' | cut -d : -f 2)

i3-msg workspace 1
i3-msg workspace $(($(i3-msg -t get_workspaces | tr , '\n' | grep '"num":' | cut -d : -f 2 | sort -rn | head -1) + 1))

if [[ $prev_workspace != 1 ]]; then
	i3-msg workspace $prev_workspace
fi

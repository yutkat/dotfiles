#!/usr/bin/env bash

layout=$(i3-msg -t get_tree | jq -r 'recurse(.nodes[]) | select(.nodes[].focused == true) | .layout')

case "$layout" in
  tabbed) : ;;
  *) i3-msg "split horizontal; layout tabbed" ;;
esac

i3-msg exec "$@"

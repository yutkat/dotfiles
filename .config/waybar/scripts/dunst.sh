#!/usr/bin/env bash
set -eu

COUNT=$(dunstctl count waiting)
ENABLED=
DISABLED=
if [ "$COUNT" != 0 ]; then DISABLED=" $COUNT"; fi
if dunstctl is-paused | grep -q "false"; then echo "$ENABLED"; else echo "$DISABLED"; fi

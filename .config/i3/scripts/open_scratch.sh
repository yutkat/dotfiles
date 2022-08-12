#!/usr/bin/env bash

i3-msg exec "$@"
sleep 0.5
i3-msg move scratchpad
i3-msg scratchpad show

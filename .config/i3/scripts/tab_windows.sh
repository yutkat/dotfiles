#!/usr/bin/env bash

id=$(~/.config/i3/scripts/id_list.py)
i3-msg [id="$id"] focus >/dev/null

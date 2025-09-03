#!/usr/bin/env bash

LAST_MESSAGE=$(echo "$1" | jq -r '.["last-assistant-message"] // "Codex task completed"')

notify-send -i codex "Codex" "$LAST_MESSAGE"

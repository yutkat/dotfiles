#!/usr/bin/env bash

args=()

for arg in "$@"; do
  if [ "$arg" != "-e" ]; then
      args+=("$arg")
  fi
done

if [ ${#args[@]} -gt 0 ]; then
  ~/.local/bin/x-terminal-emulator "${args[@]}"
fi


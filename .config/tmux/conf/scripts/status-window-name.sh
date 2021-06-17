#!/usr/bin/env bash

window_name="$1"
pane_path="$2"
default_shell_fullpath="$(\grep ^$(id -un): /etc/passwd | cut -d : -f 7-)"
default_shell="$(basename ${default_shell_fullpath})"
if [[ "$window_name" == "${default_shell}" ]]; then
  if [[ "$pane_path" == "${HOME}" ]]; then
    echo -n "~"
    exit
  fi

  dir_name=$(basename ${pane_path})
  if [[ "${#dir_name}" -gt 8 ]]; then
    echo -n "$(echo ${dir_name} | cut -b -7)…"
    exit
  fi
  echo -n "$(basename ${pane_path})"
  exit
fi

echo -n "${window_name}"

#!/usr/bin/env bash

input="$1"
command_history=$(echo -ne "${input}" | tr -s ' ' | cut -d ' ' -f 2-)

if [[ -e ${input} && $(file --mime "${input}") =~ /directory ]]; then
  ls -1 --color=always "${input}"

elif [[ -e ${input} && $(file --mime "${input}") =~ binary ]]; then
  echo -ne "${input}" is a binary file

elif [[ "${input}" =~ .*:[[:digit:]]*:.* ]]; then
  # grep
  f=$(echo -ne "${input}" | cut -d : -f 1)
  n=$(echo -ne "${input}" | cut -d : -f 2)
  (bat --color=always --style=grid,header "$f" || tail +$n "$f") 2>/dev/null | tail +$n

elif [[ -e $(echo -ne "${input}" | cut -d " " -f 2 2>/dev/null) ]]; then
  # file
  f=$(echo -ne "${input}" | cut -d " " -f 2)
  (bat --color=always --style=grid,header "$f") 2>/dev/null

elif builtin command -v "$(echo -ne "${command_history}" | cut -d ' ' -f 1)" >/dev/null 2>&1; then
  # history
  (echo -ne "${command_history}" | bat --color=always --wrap never -l sh --style=plain || echo -ne "${command_history}") 2>/dev/null

else
  (echo -ne "${input}" | bat --color=always --wrap never --style=plain || echo -ne "${input}") 2>/dev/null
fi

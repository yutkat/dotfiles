#!/usr/bin/env bash

input="$1"

if [[ -e ${input} && $(file --mime ${input}) =~ /directory ]]; then
  ls -1 --color=always ${input}
elif [[ -e ${input} && $(file --mime ${input}) =~ binary ]]; then
  echo -ne ${input} is a binary file
elif [[ ${input} =~ .*:[[:digit:]]*:.* ]]; then
  # grep
  f=$(echo -ne ${input} | cut -d : -f 1)
  n=$(echo -ne ${input} | cut -d : -f 2)
  (bat --color=always --style=grid $f || tail +$n $f) 2>/dev/null | tail +$n | head -500
elif [[ -e $(echo -ne ${input} | cut -d " " -f 2 2>/dev/null) ]]; then
  # file
  f=$(echo -ne ${input} | cut -d " " -f 2)
  (bat --color=always --style=grid $f) 2>/dev/null | head -500
elif builtin command -v $(echo -ne ${input} | tr -s " " | cut -d " " -f 2) > /dev/null 2>&1; then
  # history
  (echo -ne ${input} | bat --color=always --wrap never -l sh --style=plain || echo -ne ${input}) 2>/dev/null | head -500
else
  (echo -ne ${input} | bat --color=always --wrap never --style=plain || echo -ne ${input}) 2>/dev/null | head -500
fi


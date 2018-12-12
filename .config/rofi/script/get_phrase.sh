#!/bin/bash

if [[ ! -d ~/.cache/rofi ]]; then
  mkdir ~/.cache/rofi
fi

if [ -z "$@" ]; then
  cat ~/.cache/rofi/phrase.txt
else
  if builtin command -v xsel > /dev/null 2>&1; then
    echo $@ | tr -d '\n' | xsel -i -b
  elif builtin command -v xclip > /dev/null 2>&1; then
    echo $@ | tr -d '\n' | xclip -i -selection clipboard
  fi
fi


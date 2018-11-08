#!/bin/bash

if [[ ! -d ~/.cache/rofi ]]; then
  mkdir ~/.cache/rofi
fi

if [ -z "$@" ]; then
  cat ~/.cache/rofi/phrase.txt
else
  echo $@ | tr -d '\n' | xsel -i -b
fi


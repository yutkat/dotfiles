#!/bin/bash

if [[ ! -d ~/.cache/rofi ]]; then
  mkdir ~/.cache/rofi
fi

if [ -z "$@" ]; then
  cat ~/.cache/rofi/phrase.txt
else
  sed -ie "/$@/d" ~/.cache/rofi/phrase.txt
fi


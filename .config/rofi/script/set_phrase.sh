#!/bin/bash

if [[ ! -d ~/.cache/rofi ]]; then
  mkdir ~/.cache/rofi
fi

if [ -z "$@" ]; then
  cat ~/.cache/rofi/phrase.txt
else
  echo $@ >> ~/.cache/rofi/phrase.txt
fi


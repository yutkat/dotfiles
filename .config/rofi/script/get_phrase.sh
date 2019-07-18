#!/bin/bash

CURRENT_DIR=$(dirname "${BASH_SOURCE[0]:-$0}")
source $CURRENT_DIR/phrase.env

if [[ ! -d $cache_dir ]]; then
  mkdir $cache_dir
fi

if [ -z "$@" ]; then
  cat $phrase_file
else
  if builtin command -v xsel > /dev/null 2>&1; then
    echo $@ | tr -d '\n' | xsel -i -b
  elif builtin command -v xclip > /dev/null 2>&1; then
    echo $@ | tr -d '\n' | xclip -i -selection clipboard
  fi
fi


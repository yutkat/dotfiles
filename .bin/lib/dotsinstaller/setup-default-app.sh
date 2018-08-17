#!/bin/bash

set -ue

set_default_app() {
  local list=$1
  local dist=$2
  for target in $list;do
    local target_path=$(which $target 2> /dev/null)
    if [ $? -eq 0 ];then
      ln -snf $target_path $HOME/.bin.local/$dist
      break
    fi
  done
}

set_default_app "chromium firefox" x-www-browser
set_default_app "urxvt gnome-terminal" x-terminal-emulator


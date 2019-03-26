#!/bin/bash

function setting_lock() {
  local s_file="/etc/systemd/system/i3lock@$(whoami).service"
  cat $HOME/.i3/systemd/i3lock@user.service | envsubst | sudo tee $s_file > /dev/null
  sudo systemctl enable $(basename $s_file)
}

setting_lock

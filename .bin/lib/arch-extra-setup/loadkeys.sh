#!/usr/bin/env bash

function service-keymap() {
  local s_file="/etc/systemd/system/loadkeys.service"
  envsubst < "$HOME"/.bin/lib/arch-extra-setup/systemd/loadkeys.service | sudo tee "$s_file" > /dev/null
  sudo systemctl enable "$(basename "$s_file")"
}

service-keymap


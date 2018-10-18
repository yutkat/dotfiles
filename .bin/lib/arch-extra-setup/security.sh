#!/bin/bash

function setting_lock() {
  local s_file="/etc/systemd/system/i3lock@$(whoami).service"
  sudo tee $s_file << "EOF" > /dev/null
[Unit]
Description=i3lock
Before=sleep.target

[Service]
User=%I
Type=forking
Environment=DISPLAY=:0
ExecStart=/usr/bin/i3lock -c 282C34

[Install]
WantedBy=sleep.target
EOF

  sudo systemctl enable $(basename $s_file)
}

setting_lock

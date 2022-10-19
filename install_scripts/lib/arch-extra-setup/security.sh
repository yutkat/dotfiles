#!/usr/bin/env bash

function setting_lock() {
	local s_file
	s_file="/etc/systemd/system/i3lock@$(whoami).service"
	envsubst <"$HOME"/.config/i3/systemd-instances/i3lock@user.service | sudo tee "$s_file" >/dev/null
	sudo systemctl enable "$(basename "$s_file")"
}

paru -S --noconfirm betterlockscreen
setting_lock

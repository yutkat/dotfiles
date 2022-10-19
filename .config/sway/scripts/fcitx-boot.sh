#!/usr/bin/env bash

if builtin command -v fcitx5 >/dev/null 2>&1; then
	fcitx5 -rd &
elif builtin command -v fcitx >/dev/null 2>&1; then
	fcitx -rd &
fi

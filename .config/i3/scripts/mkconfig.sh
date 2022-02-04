#!/usr/bin/env bash

ROOT_DIR=$(
	cd "$(dirname "$0")"/.. || exit
	pwd
)
CONFIG="$ROOT_DIR/config"

[ -e "$CONFIG" ] && rm -f "$CONFIG"
cat "$ROOT_DIR/base.config" >"$CONFIG"

shopt -s extglob
raw_config=$(ls "$ROOT_DIR"/!(base*).config 2>&1)

if [[ -n "$raw_config" ]]; then
	echo "$raw_config" | xargs cat >>"$CONFIG"
fi

chmod 444 "$CONFIG"

#!/usr/bin/env bash
set -eu

function paste_wrapper() {
	local type="$1"

	if [ "${WAYLAND_DISPLAY:-}" != "" ]; then
		if builtin command -v wl-paste >/dev/null 2>&1; then
			if [ "$type" = "--primary" ]; then
				wl-paste --primary 2>/dev/null || echo ""
			else
				wl-paste 2>/dev/null || echo ""
			fi
		fi
	else
		if builtin command -v xsel >/dev/null 2>&1; then
			xsel -o "$type" 2>/dev/null || echo ""
		elif builtin command -v xclip >/dev/null 2>&1; then
			xclip -o -selection "${type//-/}" 2>/dev/null || echo ""
		fi
	fi
}

function toggle_mode() {
	if grep -qx "hidden" "$STATE_FILE" 2>/dev/null; then
		echo "unhidden" >"$STATE_FILE"
	else
		echo "hidden" >"$STATE_FILE"
	fi
}

CLIPBOARD_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/i3bar-clipboard"
mkdir -p "${CLIPBOARD_DIR}"

# Usage: clipboard.sh --primary|--clipboard
#        clipboard.sh --toggle --primary|--clipboard
if [[ "${1:-}" == "--toggle" ]]; then
	TOGGLE=1
	shift
fi
if [[ "${1:-}" == "--primary" || "${1:-}" == "--clipboard" ]]; then
	TYPE=$1
else
	echo "arg error" >&2
	exit 1
fi
STATE_FILE="$CLIPBOARD_DIR/save$TYPE.tmp"

if [[ -n "${TOGGLE:-}" ]]; then
	toggle_mode
	exit 0
fi

if [[ ! -f "$STATE_FILE" ]]; then
	echo "unhidden" >"$STATE_FILE"
fi

# Waybar has "escape": true on these modules; do not pre-escape HTML entities here.
RESULT=$(
	paste_wrapper "$TYPE" |
		tr -d '\n' |
		sed -e 's/^[ ]*//' |
		tr -dc '[:alnum:][:graph:]' |
		head -c 5 || true
)

if grep -q "unhidden" "$STATE_FILE"; then
	echo "$RESULT"
else
	echo "hidden"
fi

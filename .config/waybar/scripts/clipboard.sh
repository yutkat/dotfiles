#!/usr/bin/env bash

function copy_wrapper() {
	local type="$1"
	local input="$2"
	# if [ "$WAYLAND_DISPLAY" != "" ]; then
	#   if builtin command -v wl-copy > /dev/null 2>&1; then
	#     echo -n $input | wl-copy ${type//--clipboard/}
	#   fi
	# else
	if builtin command -v xsel >/dev/null 2>&1; then
		echo $input | xsel -i $type
	elif builtin command -v xclip >/dev/null 2>&1; then
		echo $input | xclip -i -selection ${type//-/}
	fi
	# fi
}

function paste_wrapper() {
	local type="$1"
	# wl_display@1: error 1: invalid arguments for wl_display@1.get_registry
	# Missing a seat
	# if [ "$WAYLAND_DISPLAY" != "" ]; then
	#   if builtin command -v wl-paste > /dev/null 2>&1; then
	#     wl-paste ${type//--clipboard/}
	#   fi
	# else
	if builtin command -v xsel >/dev/null 2>&1; then
		xsel -o $type
	elif builtin command -v xclip >/dev/null 2>&1; then
		xclip -o ${type//-/}
	fi
	# fi
}

function toggle_mode() {
	if cat "$STATE_FILE" | grep -q "unhidden"; then
		echo "hidden" >$STATE_FILE
	else
		echo "unhidden" >$STATE_FILE
	fi
}

if [[ $1 == "--primary" ]]; then
	TYPE=$1
elif [[ $1 == "--clipboard" ]]; then
	TYPE=$1
elif [[ $1 == "--toggle" ]]; then
	toggle_mode
	exit 0
else
	echo "arg error"
	exit 1
fi

CLIPBOARD_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/i3bar-clipboard"
mkdir -p "${CLIPBOARD_DIR}"

STATE_FILE="$CLIPBOARD_DIR/save$TYPE.tmp"

if [[ ! -f "$STATE_FILE" ]]; then
	echo "unhidden" >$STATE_FILE
fi

#COMMAND=$(echo "($(xsel -o $TYPE | grep -o '^.\{0,5\}' | sed -e 's/[^a-zA-Z0-9\-]/_/g'))")
RESULT=$(
echo "$(paste_wrapper $TYPE |
	tr -d '\n' |
	sed -e 's/^[ ]*//g' |
	sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' -e 's/"/\&quot;/g' -e 's/'"'"'/\&apos;/g' |
	grep -o '^.\{0,5\}' |
	tr -dc '[:alnum:][:graph:]\n\r')"
)
# RESULT=$(paste_wrapper $TYPE | grep -o '^.\{0,5\}')

if cat "$STATE_FILE" | grep -q "unhidden"; then
	echo "$RESULT"
else
	echo "hidden"
fi

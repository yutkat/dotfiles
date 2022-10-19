#!/usr/bin/env zsh
# options.zsh <snippet> <icon> <header> <color>
snippet="$1"
icon="$2"
header="$3"
color="$4"

command cat "${0:a:h}/../snippets/$snippet.txt" \
	| "${0:a:h}/format.zsh" "$icon" "$header" "$color"

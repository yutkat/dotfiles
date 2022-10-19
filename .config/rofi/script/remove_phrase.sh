#!/usr/bin/env bash

CURRENT_DIR=$(dirname "${BASH_SOURCE[0]:-$0}")
source "$CURRENT_DIR"/phrase.env

if [[ ! -d "$cache_dir" ]]; then
	mkdir "$cache_dir"
fi

if [ -z "$*" ]; then
	cat "$phrase_file"
else
	sed -ie "/$*/d" "$phrase_file"
fi

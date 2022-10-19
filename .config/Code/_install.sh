#!/usr/bin/env bash

set -ue

current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
cd "$current_dir"

target_dir="$HOME/.config/$(basename "$(realpath "$current_dir")")"
src_list=$(command find . -mindepth 1 -type f | command grep -v "$(basename "$0")")

for src in $src_list; do
	src_fullpath=$(readlink -f "$src")
	if [[ ! -e $(dirname "$target_dir/$src") ]]; then
		mkdir -p "$(dirname "$target_dir/$src")"
	fi
	command ln -snf "$src_fullpath" "$target_dir/$src"
done

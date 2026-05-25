#!/usr/bin/env bash
set -eu

mode=${1:-start}
input=""
if [ ! -t 0 ]; then
	input=$(cat)
fi

cwd=$PWD
if command -v jq > /dev/null 2>&1 && [ -n "$input" ]; then
	hook_cwd=$(printf '%s' "$input" | jq -r '.cwd // .workdir // .workspace_root // empty' 2> /dev/null || true)
	if [ -n "$hook_cwd" ]; then
		cwd=$hook_cwd
	fi
fi

dir=${cwd##*/}
if [ "$cwd" = "$HOME" ]; then
	dir="~"
fi

case $mode in
	stop)
		title="zsh:${dir}"
		;;
	*)
		title="codex:${dir}"
		;;
esac

title=${title//$'\e'/}
title=${title//$'\a'/}
title=${title//$'\n'/ }

if ! { printf '\033]2;%s\a' "$title" > /dev/tty; } 2> /dev/null; then
	printf '\033]2;%s\a' "$title"
fi

#!/usr/bin/env bash
set -eu

# git exports COLUMNS to the pager, so wide terminals get a side-by-side view.
if builtin command -v "delta" >/dev/null 2>&1; then
	if [[ "${COLUMNS:-0}" -gt 200 ]]; then
		delta --tabs 2 --side-by-side --width "$COLUMNS" "$@"
	else
		delta --tabs 2 "$@"
	fi
elif [[ -x /usr/share/git/diff-highlight/diff-highlight ]]; then
	/usr/share/git/diff-highlight/diff-highlight "$@"
elif builtin command -v "bat" >/dev/null 2>&1; then
	bat "$@"
else
	cat "$@"
fi

#!/usr/bin/env bash
# https://github.com/maximbaz/dotfiles/commit/925a5b88a8263805a5a24c6198dad23bfa62f44d

sessions=$(tmux list-sessions -F '#S' | grep '^[0-9]\+$' | sort -n)

new=1
for old in $sessions; do
	tmux rename -t "$old" "$new"
	((new++))
done

#!/usr/bin/env zsh
icon="\uf412"
header="tag"

name="%(refname:short)"
subject="%(subject)"
committer_date="%(committerdate:relative)"

git --no-pager for-each-ref \
	'refs/tags' \
	--format="$name%09$subject%09$committer_date" \
	--sort='-committerdate' \
	2> /dev/null \
	| "${0:a:h}/format.zsh" "$icon" "$header" "green" "green" "gray" "dark_blue" "6" "13"

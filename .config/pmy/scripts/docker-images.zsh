#!/usr/bin/env zsh
icon="\uf7c9"
header="image"

docker images --format="{{.Repository}}:{{.Tag}}\t{{.ID}} {{.Size}}\t{{.CreatedSince}}" \
	| "${0:a:h}/format.zsh" "$icon" "$header" "green" "white" "dark_green" "dark_blue"

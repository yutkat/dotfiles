#!/usr/bin/env zsh
. "${0:a:h}/ansi.zsh"

icon="$(print "\ue71e")"
header="script"

reset="$ansi[reset]"
header_style="$ansi[yellow]"
name_style="$ansi[bold]"
desc_style="$ansi[dark_green]"

root="$(npm root)"
package="$(dirname -- "$root")/package.json"

out_format=""
out_format+="$header_style%s %-7s$reset  "  # header
out_format+="$name_style%-20s$reset  "      # name
out_format+="$desc_style%s$reset\n"         # script

jq -r '.scripts | to_entries | map(.key + "\t" + .value)[]' "$package" 2> /dev/null \
	| awk -F '\t' \
	-v fmt="$out_format" \
	-v icon="$icon" \
	-v header="$header" \
	'{ printf fmt, icon, header, $1, $2 }'

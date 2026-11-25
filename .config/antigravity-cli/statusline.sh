#!/usr/bin/env bash
# Antigravity CLI status line: directory | branch | model | context usage.
# The CLI passes the session state as JSON on stdin; missing fields are skipped.
set -eu

jq -r '
	[
		((.workspace.current_dir // .cwd // "") | if startswith(env.HOME) then "~" + .[env.HOME | length:] else . end),
		(.vcs.branch // ""),
		(.model | if type == "object" then .display_name // "" elif type == "string" then . else "" end),
		(.context_window.used_percentage | if type == "number" then "ctx \(floor)%" else "" end)
	]
	| map(select(. != ""))
	| join(" | ")
'

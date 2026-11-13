#!/usr/bin/env bash
# Stop hook for Claude Code and Codex: copy the last fenced code block marked
# "copy" (e.g. ```sh copy) in the final reply to the Wayland primary selection,
# so the next command can be pasted with Shift+Insert without hand-copying.
set -eu

input=$(cat)

text=$(printf '%s' "$input" | jq -r '.last_assistant_message // empty')
if [ -z "$text" ]; then
	transcript=$(printf '%s' "$input" | jq -r '.transcript_path // empty')
	if [ -z "$transcript" ] || [ ! -f "$transcript" ]; then
		exit 0
	fi
	# The final reply is the last text block written by the assistant
	text=$(jq -rs '[.[] | select(.type == "assistant") | .message.content[]? | select(.type == "text") | .text] | last // empty' "$transcript")
fi

block=$(printf '%s\n' "$text" | awk '
	/^[ \t]*```/ {
		if (!inside) {
			inside = 1
			match($0, /^[ \t]*/)
			indent = RLENGTH
			info = $0
			sub(/^[ \t]*`+/, "", info)
			marked = (info ~ /(^|[ \t])copy([ \t]|$)/)
			buf = ""
			next
		}
		inside = 0
		if (marked) last = buf
		next
	}
	inside {
		# Drop the fence indentation (blocks nested in list items)
		line = $0
		for (i = 0; i < indent && substr(line, 1, 1) == " "; i++) line = substr(line, 2)
		buf = buf line "\n"
	}
	END { printf "%s", last }
')

if [ -z "$block" ]; then
	exit 0
fi

printf '%s' "$block" | wl-copy --primary --trim-newline
notify-send 'Copied to primary selection' "$(printf '%s\n' "$block" | head -n 1)"

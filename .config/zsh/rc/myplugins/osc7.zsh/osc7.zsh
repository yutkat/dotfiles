# Report the current directory to the terminal as an OSC 7 file:// URL;
# WezTerm reads it via pane:get_current_working_dir() for tab titles and
# for spawning panes in the same directory.

function __osc7_report_cwd() {
	emulate -L zsh
	setopt extended_glob
	local LC_ALL=C
	# Percent-encode every byte outside the URL-safe set, byte by byte.
	printf '\e]7;file://%s%s\e\\' "$HOST" "${PWD//(#m)([^@-Za-z&-;_~-])/%${(l:2::0:)$(([##16]#MATCH))}}"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd __osc7_report_cwd

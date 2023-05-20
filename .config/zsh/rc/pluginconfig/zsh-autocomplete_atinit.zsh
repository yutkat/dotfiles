zstyle ':autocomplete:*' default-context ''
# '': Start each new command line with normal autocompletion.
# history-incremental-search-backward: Start in live history search mode.

zstyle ':autocomplete:*' min-delay 0.05      # number of seconds (float)
# 0:   Start autocompletion immediately when you stop typing.
# 0.4: Wait 0.4 seconds for more keyboard input before showing completions.

zstyle ':autocomplete:*' min-input 1      # number of characters (integer)
# 0: Show completions immediately on each new command line.
# 1: Wait for at least 1 character of input.

zstyle ':autocomplete:*' ignored-input '' # (extended) glob pattern
# '':     Always show completions.
# '..##': Don't show completions when the input consists of two or more dots.

# When completions don't fit on screen, show up to this many lines:
#zstyle ':autocomplete:*' list-lines 16  # (integer)
# NOTE: The actual amount shown can be less.
zstyle -e ':autocomplete:*' list-lines 'reply=( $(( LINES / 3 )) )'

# zstyle ':autocomplete:*' list-lines 16  # int
# If there are fewer than this many lines below the prompt, move the prompt up
# to make room for showing this many lines of completions (approximately).

zstyle ':autocomplete:history-search:*' list-lines 16  # int
# Show this many history lines when pressing ↑.

zstyle ':autocomplete:history-incremental-search-*:*' list-lines 16  # int
# Show this many history lines when pressing ⌃R or ⌃S.

zstyle ':autocomplete:*' insert-unambiguous no
# no:  (Shift-)Tab inserts top (bottom) completion.
# yes: Tab first inserts substring common to all listed completions (if any).

zstyle ':autocomplete:*' add-space \
	executables aliases functions builtins reserved-words commands

# Order in which completions are listed on screen, if shown at the same time:
zstyle ':completion:*:' tag-order '! history-words' -
zstyle ':completion:*:' group-order \
	expansions options \
	executables local-directories directories suffix-aliases \
	aliases functions builtins reserved-words commands

# history-words

# Add a space after these completions:
#zstyle ':autocomplete:*' add-space executables aliases functions builtins reserved-words commands

# Patch
zstyle ':completion:*:messages' format
zstyle ':completion:*:warnings' format
zstyle ':completion:*:descriptions' format
zstyle ':completion:*:corrections' format
zstyle ':completion:*:default' menu

autoload -Uz add-zle-hook-widget
if ! builtin command -v compinit > /dev/null 2>&1; then
	autoload -Uz compinit
	if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
		compinit
	else
		compinit -C
	fi
fi

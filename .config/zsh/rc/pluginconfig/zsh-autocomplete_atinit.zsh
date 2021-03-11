zstyle ':autocomplete:*' default-context ''
# '': Start each new command line with normal autocompletion.
# history-incremental-search-backward: Start in live history search mode.

zstyle ':autocomplete:*' min-delay 0      # number of seconds (float)
# 0:   Start autocompletion immediately when you stop typing.
# 0.4: Wait 0.4 seconds for more keyboard input before showing completions.

zstyle ':autocomplete:*' min-input 0      # number of characters (integer)
# 0: Show completions immediately on each new command line.
# 1: Wait for at least 1 character of input.

zstyle ':autocomplete:*' ignored-input '' # (extended) glob pattern
# '':     Always show completions.
# '..##': Don't show completions when the input consists of two or more dots.

zstyle ':autocomplete:tab:*' insert-unambiguous no
# no:  (Shift-)Tab inserts top (bottom) completion.
# yes: Tab first inserts substring common to all listed completions (if any).

zstyle ':autocomplete:tab:*' widget-style menu-select
# complete-word: (Shift-)Tab inserts top (bottom) completion.
# menu-complete: Press again to cycle to next (previous) completion.
# menu-select:   Same as `menu-complete`, but updates selection in menu.
# NOTE: Can NOT be changed at runtime.

zstyle ':autocomplete:tab:*' fzf-completion no
# no:  Tab uses Zsh's completion system only.
# yes: Tab first tries Fzf's completion, then falls back to Zsh's.
# NOTE 1: Can NOT be changed at runtime.
# NOTE 2: Requires that you have installed Fzf's shell extensions.

# Order in which completions are listed on screen, if shown at the same time:
zstyle ':completion:*:' group-order \
  expansions options \
  executables local-directories directories suffix-aliases \
  aliases functions builtins reserved-words
# history-words

autoload -Uz add-zle-hook-widget
if ! builtin command -v compinit > /dev/null 2>&1; then
  autoload -Uz compinit && compinit -u
fi

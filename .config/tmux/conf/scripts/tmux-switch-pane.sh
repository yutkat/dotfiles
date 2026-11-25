#!/bin/bash

#https://www.reddit.com/r/tmux/comments/kvf2n4/tmux_and_fzf_fuzzy_tmux_sessionwindowpane_switcher/

# customizable
LIST_DATA="#{window_name} #{pane_title} #{pane_current_path} #{pane_current_command}"
FZF_COMMAND="fzf-tmux -p --delimiter=: --with-nth 4 --color=hl:2"

# do not change
TARGET_SPEC="#{session_name}:#{window_id}:#{pane_id}:"

# select pane
LINE=$(tmux list-panes -a -F "$TARGET_SPEC $LIST_DATA" | $FZF_COMMAND) || exit 0
IFS=: read -r session window pane _ <<<"$LINE"
# activate session/window/pane
tmux select-pane -t "$pane" && tmux select-window -t "$window" && tmux switch-client -t "$session"

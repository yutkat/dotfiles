#!/usr/bin/env bash

width=${2:-80%}
height=${2:-80%}
if [ "$(tmux display-message -p -F "#{session_name}")" = "popup" ]; then
  tmux detach-client
else
  tmux popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -K -E -R "tmux attach -t popup || tmux new -s popup"
fi

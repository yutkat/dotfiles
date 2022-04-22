#!/usr/bin/env bash
xargs -I {} tmux split-window -hc "#{pane_current_path}" "$EDITOR" {}

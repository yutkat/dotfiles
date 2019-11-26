#!/usr/bin/env bash
xargs -i tmux split-window -hc "#{pane_current_path}" $EDITOR {}

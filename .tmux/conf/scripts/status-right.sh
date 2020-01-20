#!/bin/bash

if [[ $(tmux display -p "#{client_width}") -ge 150 ]]; then
  STATUS_RIGHT_LONG="#[bg=colour=236 fg=colour240]${TMUX_POWERLINE_SYMBOL_LEFT_FULL} #[bg=colour240 fg=colour231] #H #[bg=colour240 fg=colour252]${TMUX_POWERLINE_SYMBOL_LEFT_FULL}#[fg=colour235 bg=colour252 nobold] $(LANG=C date '+%Y-%m-%d(%a) %H:%M') "
else
  STATUS_RIGHT_LONG=""
fi

echo -n "$STATUS_RIGHT_LONG"


#!/usr/bin/env bash

SYS_PLUGIN_DIR="$TMUX_PLUGIN_MANAGER_PATH/tmux-plugin-sysstat/scripts"
SYS_STATUS=""

if [[ -d "${SYS_PLUGIN_DIR}" ]]; then
  SYS_STATUS=" [$(${SYS_PLUGIN_DIR}/cpu.sh):$(${SYS_PLUGIN_DIR}/mem.sh):$(df -h | grep -w '/' | tr -s ' ' | cut -d ' ' -f 5)]"
fi

if [[ $(tmux display -p "#{client_width}") -ge 300 ]]; then
  STATUS_RIGHT_LONG="#[bg=colour=236 fg=colour240]${TMUX_POWERLINE_SYMBOL_LEFT_FULL} #[bg=colour240 fg=colour231] #H${SYS_STATUS} #[bg=colour240 fg=colour252]${TMUX_POWERLINE_SYMBOL_LEFT_FULL}#[fg=colour235 bg=colour252 nobold] $(LANG=C date '+%Y-%m-%d(%a) %H:%M') "
elif [[ $(tmux display -p "#{client_width}") -ge 150 ]]; then
  STATUS_RIGHT_LONG="#[bg=colour=236 fg=colour240]${TMUX_POWERLINE_SYMBOL_LEFT_FULL} #[bg=colour240 fg=colour231] #h${SYS_STATUS} #[bg=colour240 fg=colour252]${TMUX_POWERLINE_SYMBOL_LEFT_FULL}#[fg=colour235 bg=colour252 nobold] $(LANG=C date '+%Y-%m-%d(%a) %H:%M') "
else
  STATUS_RIGHT_LONG=""
fi

echo -n "$STATUS_RIGHT_LONG"


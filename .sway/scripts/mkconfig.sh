#!/usr/bin/env sh

cd $(dirname $0)

SWAY_CONFIG="$HOME/.sway/config"

[ -e $SWAY_CONFIG ] && rm -f $SWAY_CONFIG
cat ~/.sway/config.base > $SWAY_CONFIG

if builtin command -v "swaymsg" > /dev/null 2>&1; then
  if [ $(swaymsg aaa 2>&1 | \grep gaps | wc -l) -ne 0 ]; then
    cat ~/.sway/config.gaps  >> $SWAY_CONFIG
  fi
fi

if [ -f "$HOME/.sway/config.local" ]; then
  cat "$HOME/.sway/config.local" >> $SWAY_CONFIG
fi

chmod 444 $SWAY_CONFIG


#!/usr/bin/env sh

cd $(dirname $0)

SWAY_CONFIG="$HOME/.sway/config"

[ -e $SWAY_CONFIG ] && rm -f $SWAY_CONFIG
cat ~/.sway/config.base > $SWAY_CONFIG

if builtin command -v "swaymsg" > /dev/null 2>&1; then
  if [ $(swaymsg aaa 2>&1 | \grep gaps | wc -l) -ne 0 ]; then
    if [[ -f "~/.sway/config.*" ]]; then
      cat ~/.sway/config.*  >> $SWAY_CONFIG
    fi
  fi
fi

chmod 444 $SWAY_CONFIG


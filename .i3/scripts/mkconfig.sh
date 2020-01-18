#!/usr/bin/env sh

cd $(dirname $0)

I3_CONFIG="$HOME/.i3/config"

[ -e $I3_CONFIG ] && rm -f $I3_CONFIG
cat ~/.i3/config.base > $I3_CONFIG

if builtin command -v "i3-msg" > /dev/null 2>&1; then
  if [ $(i3-msg aaa 2>&1 | \grep gaps | wc -l) -ne 0 ]; then
    cat ~/.i3/config.gaps  >> $I3_CONFIG
  fi
fi

if [ -f "$HOME/.i3/config.local" ]; then
  cat "$HOME/.i3/config.local" >> $I3_CONFIG
fi

chmod 444 $I3_CONFIG


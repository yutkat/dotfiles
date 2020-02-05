#!/usr/bin/env bash

CARD=$(aplay -l | awk -F \: '/,/{print $2}' | awk '{print $1}' | uniq | head -n 1)

if command -v pulseaudio >/dev/null 2>&1 && pulseaudio --check ; then
  # pulseaudio is running, but not all installations use "pulse"
  if amixer -c $CARD -D pulse info >/dev/null 2>&1 ; then
    MIXER="pulse"
  fi
fi

if [ -n "$(lsmod | grep jack)" ]; then
  MIXER="jackplug"
fi

MIXER=$(amixer info  -c PCH | grep Card | cut -d ' ' -f 2)
MIXER=${MIXER:-default}
SCONTROL="${BLOCK_INSTANCE:-$(amixer -c $CARD -D $MIXER scontrols |
                sed -n "s/Simple mixer control '\([^']*\)',0/\1/p" |
                head -n1
              )}"
echo -n "$SCONTROL"

#!/bin/sh

nmodules="$(pactl list modules short 2> /dev/null | grep -c noisetorch)"
[ "$nmodules" = 0 ] && echo "off" || echo "on"


#!/bin/sh

case $1 in
      "*") command="" ;;
      "up") command="--allow-boost -i 5" ;;
      "down") command="--allow-boost -d 5" ;;
      "toogle") command="-t" ;;
esac

[ -n "$command" ] && pamixer --default-source $command 
mute=$(pamixer --default-source --get-mute)
if [ "$mute" = "true" ]; then
      volume="muted"
      icon=""
else 
      volume="$(pamixer --default-source --get-volume)%"
      icon=""
fi

echo "{\"content\": \"$volume\", \"icon\": \"$icon\"}"





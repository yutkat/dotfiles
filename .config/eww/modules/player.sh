#!/bin/sh


echo "{\"show\": \"no\", \"content\": \"\"}"
playerctl --follow metadata --format '{{artist}} ¿¿¿¿¿ {{ title }}' 2> /dev/null | while read -r line ; do 
   case "$line" in
     ?*\ ¿¿¿¿¿\ ?*) text="$(echo "$line" | sed "s/¿¿¿¿¿/-/")" && should_show="yes";;
     *) text="" && should_show="no" ;;
  esac

  echo "{\"show\": \"$should_show\", \"content\": \"(box (label :text \\\"$text\\\"))\"}"
done 


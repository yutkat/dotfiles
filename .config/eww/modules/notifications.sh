#!/bin/sh

print_notification() {
  content=$(echo "$1" | tr '\n' ' ')
  content="(label :text '$content')"
  echo "{\"show\": \"$2\", \"content\": \"$content\"}"
}

print_notification "" "no"
tiramisu -o '#summary' | while read -r line; do 
  print_notification "$line" "yes"
  kill "$pid"
  (sleep 10; print_notification "" "no") &
  pid="$!"
done

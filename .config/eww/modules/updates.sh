#!/bin/sh

updates_arch=$(checkupdates 2> /dev/null | wc -l );
[ -z "$updates_arch" ] && updates_arch=0

updates_aur=$(checkupdates-aur 2> /dev/null | wc -l)
[ -z "$updates_aur" ] && updates_aur=0

updates=$((updates_arch + updates_aur))
echo "$updates"

#[ "$updates" -gt 0 ] && echo "$updates" || echo "A"





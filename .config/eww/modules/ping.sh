#!/bin/sh

HOST="8.8.8.8"

if  ! ping=$(ping -n -c 1 -W 1 $HOST 2> /dev/null); then
    echo "No"
else
    rtt=$(echo "$ping" | sed -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p')
    
    [ -z "$rtt" ] && echo "" && exit
    echo "$rtt ms"
fi

#!/bin/sh

notifications="$(gh api notifications 2> /dev/null | jq '. | length')"
[ -z notifications ] && echo "" || echo "$notifications" 

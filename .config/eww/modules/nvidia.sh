#!/bin/sh

nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits -l 2 2>/dev/null | while read -r line; do
	[ "$line" = "Failed" ] && echo "Failed" || echo "$line%"
done

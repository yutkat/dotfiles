#!/usr/bin/env bash

export DISPLAY=:0
X_USER=$(w -h -s | head -1 | awk '{print $1}')
export XAUTHORITY=/home/$X_USER/.Xauthority

XRANDR="xrandr"
CMD="${XRANDR}"
declare -A VOUTS
eval VOUTS=$(${XRANDR} | awk 'BEGIN {printf("(")} /^\S.*connected/{printf("[%s]=%s ", $1, $2)} END{printf(")")}')

MAIN_DISPLAY=$(xrandr | awk '/^\S.* connected/{printf("%s\n", $1)}' | head -n 1)
OPTION="--same-as ${MAIN_DISPLAY}"
for VOUT in $(xrandr | awk '/^\S.* connected/{printf("%s\n", $1)}' | tail -n +2); do
	CMD="${CMD} --output ${VOUT} --auto ${OPTION}"
done

echo ${CMD}
set -x
${CMD}
set +x

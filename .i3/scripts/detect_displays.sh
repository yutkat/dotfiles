#!/usr/bin/env bash

export DISPLAY=:0
X_USER=$(w -h -s | head -1 | awk '{print $1}')
export XAUTHORITY=/home/$X_USER/.Xauthority

# /etc/udev/rules.d/95-monitor-hotplug.rules
# eg. SUBSYSTEM=="drm", ACTION=="change", ENV{DISPLAY_LAYOUT}="left", ENV{DISPLAY_ROTATE}="left", RUN+="/usr/local/bin/detect_displays.sh"
LAYOUT=${DISPLAY_LAYOUT:-right}
if [[ -n "$DISPLAY_ROTATE" ]]; then
  ROTATE="--rotate ${DISPLAY_ROTATE}"
else
  ROTATE=""
fi

XRANDR="xrandr"
CMD="${XRANDR}"
declare -A VOUTS
eval VOUTS=$(${XRANDR} | awk 'BEGIN {printf("(")} /^\S.*connected/{printf("[%s]=%s ", $1, $2)} END{printf(")")}')
declare -A RESOL
eval RESOL=$(xrandr | awk 'BEGIN {printf("(")} /^\S.*connected.*$/{printf("[%s]=", $1); getline; printf("%s ", $1)} END{printf(")")}')
declare -A POS
#XPOS=0
#YPOS=0
#POS="${XPOS}x${YPOS}"

POS=([X]=0 [Y]=0)

find_mode() {
  echo $(${XRANDR} | grep ${1} -A1 | awk '{FS="[ x]"} /^\s/{printf("WIDTH=%s\nHEIGHT=%s", $4,$5)}')
}

xrandr_params_for() {
  if [ "${2}" == 'connected' ]; then
    # eval $(find_mode ${1})  #sets ${WIDTH} and ${HEIGHT}
    # MODE="${WIDTH}x${HEIGHT}"
    # CMD="${CMD} --output ${1} --mode ${MODE} --pos ${POS[X]}x${POS[Y]}"
    # POS[X]=$((${POS[X]}+${WIDTH}))
    CMD="${CMD} --output ${1} --auto $3"
    return 0
  else
    CMD="${CMD} --output ${1} --off"
    return 1
  fi
}

# for VOUT in ${!VOUTS[*]}; do
#   xrandr_params_for ${VOUT} ${VOUTS[${VOUT}]} $OPTION
# done
OPTION=""
for VOUT in $(# xrandr display order
  xrandr | awk '/^\S.*connected/{printf("%s\n", $1)}' | (
    sed -u 1q
    sort
  )
); do
  if xrandr_params_for ${VOUT} ${VOUTS[${VOUT}]} "$OPTION"; then
    OPTION="--${LAYOUT}-of ${VOUT} ${ROTATE}"
  fi
done

echo ${CMD}
${CMD}

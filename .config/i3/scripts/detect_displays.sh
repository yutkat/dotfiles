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
eval RESOL=$(${XRANDR} | awk 'BEGIN {printf("(")} /^\S.*connected.*$/{printf("[%s]=", $1); getline; printf("%s ", $1)} END{printf(")")}')
ALL_DISPLAY_NAME=$(xrandr | awk '/^\S.*connected/{printf("%s\n", $1)}' | (
		sed -u 1q
		sort
))
CONNECTED_DISPLAY_NAME=$(xrandr | awk '/^\S.*[^dis]connected/{printf("%s\n", $1)}' | (
		sed -u 1q
		sort
))
#XPOS=0
#YPOS=0
#POS="${XPOS}x${YPOS}"

declare -A POS
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

get_diff_height() {
	local max_width=0
	local min_width=100000
	local max_height=0
	local min_height=100000

	for VOUT in ${CONNECTED_DISPLAY_NAME}; do
		local size=${RESOL[${VOUT}]}
		local width=${size%x*}
		local height=${size#*x}
		if [[ $width -gt $max_width ]]; then
			max_width=$width
		fi
		if [[ $width -lt $min_width ]]; then
			min_width=$width
		fi
		if [[ $height -gt $max_height ]]; then
			max_height=$height
		fi
		if [[ $height -lt $min_height ]]; then
			min_height=$height
		fi
	done

	echo $(("$max_height" - "$min_height"))
}

## bottom base
#if [[ "$DISPLAY_LAYOUT" == "right" ]]; then
#  EXPAND_DIRECTION="-"
#  ALL_DISPLAY_NAME=$(
#    printf '%s\n' "${ALL_DISPLAY_NAME[@]}" | tac | tr '\n' ' '
#    echo
#  )
#else
#  EXPAND_DIRECTION=""
#fi
#OPTION="--pos 0x${EXPAND_DIRECTION}$(get_diff_height)"
#total_width=0
#for VOUT in ${ALL_DISPLAY_NAME}; do
#  if xrandr_params_for ${VOUT} ${VOUTS[${VOUT}]} "$OPTION"; then
#    cur_size=${RESOL[${VOUT}]}
#    cur_width=${cur_size%x*}
#    total_width=$(("${total_width}" + "${cur_width}"))
#    OPTION="--pos ${total_width}x0"
#  fi
#done

# top base
OPTION=""
for VOUT in ${ALL_DISPLAY_NAME}; do
	if xrandr_params_for ${VOUT} ${VOUTS[${VOUT}]} "$OPTION"; then
		OPTION="--${LAYOUT}-of ${VOUT} ${ROTATE}"
	fi
done

echo "${CMD}"
${CMD}

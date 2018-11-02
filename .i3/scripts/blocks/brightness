#!/bin/bash

# One of the following: xrandr, xbacklight, kernel
METHOD="xbacklight"

# Left click
if [[ "${BLOCK_BUTTON}" -eq 1 ]]; then
  xbacklight -inc 5
# Right click
elif [[ "${BLOCK_BUTTON}" -eq 3 ]]; then
  xbacklight -dec 5
fi

URGENT_VALUE=10

if [[ "${METHOD}" = "xrandr" ]]; then
  device="${BLOCK_INSTANCE:-primary}"
  xrandrOutput=$(xrandr --verbose)

  if [[ "${device}" = "primary" ]]; then
    device=$(echo "${xrandrOutput}" | grep 'primary' | head -n 1 | awk -F ' ' '{print $1}')
  fi

  curBrightness=$(echo "${xrandrOutput}" | grep "${device}" -A 5 | grep -i "Brightness" | awk -F ':' '{print $2}')
elif [[ "${METHOD}" = "kernel" ]]; then
  device="${BLOCK_INSTANCE:-intel_backlight}"
  maxBrightness=$(cat /sys/class/backlight/${device}/max_brightness)
  curBrightness=$(cat /sys/class/backlight/${device}/brightness)
elif [[ "${METHOD}" = "xbacklight" ]]; then
  curBrightness=$(xbacklight -get)
fi

if [[ "${curBrightness}" -le 0 ]]; then
  exit
fi

if [[ "${METHOD}" = "xrandr" ]]; then
  percent=$(echo "scale=0;${curBrightness} * 100" | bc -l)
elif [[ "${METHOD}" = "kernel" ]]; then
  percent=$(echo "scale=0;${curBrightness} / ${maxBrightness} * 100" | bc -l)
elif [[ "${METHOD}" = "xbacklight" ]]; then
  percent=$(echo "scale=0;${curBrightness}" | bc -l)
fi

percent=${percent%.*}

if [[ "${percent}" -le 0 ]]; then
  exit
fi

echo "${percent}%"
echo "${percent}%"
echo ""

if [[ "${percent}" -le "${URGENT_VALUE}" ]]; then
  exit 33
fi

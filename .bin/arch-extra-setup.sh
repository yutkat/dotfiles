#!/bin/bash

set -ue

current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
source $current_dir/lib/dotsinstaller/utilfuncs.sh

function helpmsg() {
  print_default "Usage: "${BASH_SOURCE[0]:-$0}" [--extra] [--multi-display] [--security] [--all] [--help | -h]" 0>&2
  print_default '  --all: --extra + --multi-display + --security'
  print_default ""
}

EXTRA="false"
MULTI_DISPLAY="false"
SECURITY="false"

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    --extra)
      EXTRA="false"
      ;;
    --multi-display)
      MULTI_DISPLAY="false"
      ;;
    --security)
      SECURITY="false"
      ;;
    --all)
      EXTRA="true"
      MULTI_DISPLAY="true"
      SECURITY="true"
      ;;
    *)
      ;;
  esac
  shift
done

source $current_dir/lib/arch-extra-setup/utils.sh
source $current_dir/lib/arch-extra-setup/development.sh

if [ -f /sys/module/battery/initstate ] || [ -d /proc/acpi/battery/BAT0 ]; then
  source $current_dir/lib/arch-extra-setup/laptop.sh
fi

if [[ "$EXTRA" = true ]];then
  source $current_dir/lib/arch-extra-setup/apps.sh
  source $current_dir/lib/arch-extra-setup/equipment.sh
fi

if [[ "$MULTI_DISPLAY" = true ]];then
  source $current_dir/lib/arch-extra-setup/multi-display.sh
fi

if [[ "$SECURITY" = true ]];then
  source $current_dir/lib/arch-extra-setup/security.sh
fi


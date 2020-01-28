#!/usr/bin/env bash

set -ue

CURRENT_DIR=$(dirname "${BASH_SOURCE[0]:-$0}")
source $CURRENT_DIR/lib/dotsinstaller/utilfuncs.sh

function helpmsg() {
  print_default "Usage: "${BASH_SOURCE[0]:-$0}" [--extra] [--multi-display] [--security] [--all] [--help | -h]" 0>&2
  print_default '  --all: --extra + --multi-display + --security'
  print_default ""
}

function main() {
  local extra="false"
  local multi_display="false"
  local security="false"

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
        extra="false"
        ;;
      --multi-display)
        multi_display="false"
        ;;
      --security)
        security="false"
        ;;
      --all)
        extra="true"
        multi_display="true"
        security="true"
        ;;
      *)
        ;;
    esac
    shift
  done

  source $CURRENT_DIR/lib/arch-extra-setup/utils.sh
  source $CURRENT_DIR/lib/arch-extra-setup/development.sh

  if [ -f /sys/module/battery/initstate ] || [ -d /proc/acpi/battery/BAT0 ]; then
    source $CURRENT_DIR/lib/arch-extra-setup/laptop.sh
  fi

  if [[ "$extra" = true ]];then
    source $CURRENT_DIR/lib/arch-extra-setup/apps.sh
    source $CURRENT_DIR/lib/arch-extra-setup/equipment.sh
  fi

  if [[ "$multi_display" = true ]];then
    source $CURRENT_DIR/lib/arch-extra-setup/udev/multi-display.sh
  fi

  if [[ "$security" = true ]];then
    source $CURRENT_DIR/lib/arch-extra-setup/security.sh
  fi
}

main "$@"


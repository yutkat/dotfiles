#!/usr/bin/env bash

set -ue

function helpmsg() {
  print_default "Usage: ${BASH_SOURCE[0]:-$0} [--extra] [--multi-display] [--laptop] [--security] [--all] [--help | -h]" 0>&2
  print_default '  --all: --extra + --multi-display + --laptop + --security'
  print_default ""
}

function main() {
  local current_dir
  current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
  source $current_dir/lib/dotsinstaller/utilfuncs.sh

  local extra="false"
  local multi_display="false"
  local laptop="false"
  local security="false"

  while [ $# -gt 0 ]; do
    case ${1} in
    --debug | -d)
      set -uex
      ;;
    --help | -h)
      helpmsg
      exit 1
      ;;
    --extra)
      extra="true"
      ;;
    --multi-display)
      multi_display="true"
      ;;
    --laptop)
      laptop="true"
      ;;
    --security)
      security="true"
      ;;
    --all)
      extra="true"
      multi_display="true"
      security="true"
      laptop="true"
      ;;
    *) ;;

    esac
    shift
  done

  source $current_dir/lib/arch-extra-setup/development.sh
  source $current_dir/lib/arch-extra-setup/utils.sh

  if [ -f /sys/module/battery/initstate ] || [ -d /proc/acpi/battery/BAT0 ]; then
    source $current_dir/lib/arch-extra-setup/laptop.sh
  fi

  if [[ "$extra" = true ]]; then
    source $current_dir/lib/arch-extra-setup/apps.sh
    source $current_dir/lib/arch-extra-setup/equipment.sh
  fi

  if [[ "$multi_display" = true ]]; then
    source $current_dir/lib/arch-extra-setup/udev/multi-display.sh
  fi
  if [[ "$laptop" = true ]]; then
    source $current_dir/lib/arch-extra-setup/udev/laptop-keyboard.sh
    source $current_dir/lib/arch-extra-setup/udev/trackpoint.sh
  fi

  if [[ "$security" = true ]]; then
    source $current_dir/lib/arch-extra-setup/security.sh
  fi

  print_info ""
  print_info "#####################################################"
  print_info "$(basename "${BASH_SOURCE[0]:-$0}") install finish!!!"
  print_info "#####################################################"
  print_info ""
}

main "$@"

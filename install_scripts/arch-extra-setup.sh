#!/usr/bin/env bash

set -ue

function helpmsg() {
	print_default "Usage: ${BASH_SOURCE[0]:-$0} [--gui] [--extra] [--laptop] [--all] [--help | -h]" 0>&2
	print_default '  --all: --gui + --extra + --laptop'
	print_default ""
}

function main() {
	local current_dir
	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	source $current_dir/lib/dotsinstaller/utilfuncs.sh

	local gui="false"
	local extra="false"
	local laptop="false"

	while [ $# -gt 0 ]; do
		case ${1} in
			--debug | -d)
				set -uex
				;;
			--help | -h)
				helpmsg
				exit 1
				;;
			--gui)
				gui="true"
				;;
			--extra)
				extra="true"
				;;
			--multi-display)
				;;
			--laptop)
				laptop="true"
				;;
			--all)
				gui="true"
				extra="true"
				laptop="true"
				;;
			*) ;;

		esac
		shift
	done

	source $current_dir/lib/arch-extra-setup/aur-helper.sh
	source $current_dir/lib/arch-extra-setup/development.sh

	if [ -f /sys/module/battery/initstate ] || [ -d /proc/acpi/battery/BAT0 ]; then
		source $current_dir/lib/arch-extra-setup/laptop.sh
	fi

	if [[ "$gui" = true ]]; then
		source $current_dir/lib/arch-extra-setup/gui.sh
	fi

	if [[ "$extra" = true ]]; then
		source $current_dir/lib/arch-extra-setup/apps.sh
		source $current_dir/lib/arch-extra-setup/equipment.sh
	fi

	if [[ "$laptop" = true ]]; then
		source $current_dir/lib/arch-extra-setup/udev/laptop-keyboard.sh
		source $current_dir/lib/arch-extra-setup/udev/trackpoint.sh
	fi

	print_info ""
	print_info "#####################################################"
	print_info "$(basename "${BASH_SOURCE[0]:-$0}") install finish!!!"
	print_info "#####################################################"
	print_info ""
}

main "$@"

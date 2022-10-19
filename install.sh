#!/usr/bin/env bash

set -ue

function helpmsg() {
	print_default "Usage: ${BASH_SOURCE[0]:-$0} [--gui] [--arch] [--all] [--help | -h]" 0>&2
	print_default '  --all: --gui + --arch'
	print_default ""
}

function main() {
	local current_dir
	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	source "${current_dir}"/install_scripts/lib/dotsinstaller/utilfuncs.sh

	local gui="false"
	local arch="false"

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
			--arch)
				arch="true"
				;;
			--all)
				gui="true"
				arch="true"
				;;
			*) ;;

		esac
		shift
	done

	if [[ "$gui" = true ]]; then
		"${current_dir}"/install_scripts/dotsinstaller.sh install --with-gui
	else
		"${current_dir}"/install_scripts/dotsinstaller.sh install
	fi

	if [[ "$arch" = true ]]; then
		"${current_dir}"/install_scripts/arch-extra-setup.sh --all
	fi

	print_info ""
	print_info "#####################################################"
	print_info "$(basename "${BASH_SOURCE[0]:-$0}") install finish!!!"
	print_info "#####################################################"
	print_info ""
}

main "$@"

#!/usr/bin/env bash

set -ue

#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#

function helpmsg() {
	print_default "Usage: ${BASH_SOURCE[0]:-$0} [install | update | link] [--with-gui] [--help | -h]" 0>&2
	print_default "  install: add require package install and symbolic link to $HOME from dotfiles [default]"
	print_default "  update: add require package install or update."
	print_default "  link: only symbolic link to $HOME from dotfiles."
	print_default ""
}

#--------------------------------------------------------------#
##          main                                              ##
#--------------------------------------------------------------#

function main() {
	local current_dir
	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	source $current_dir/lib/dotsinstaller/utilfuncs.sh

	local is_install="false"
	local is_link="false"
	local is_update="false"
	local with_gui="false"

	while [ $# -gt 0 ]; do
		case ${1} in
			--help | -h)
				helpmsg
				exit 1
				;;
			install)
				is_install="true"
				is_update="true"
				is_link="true"
				;;
			update)
				is_install="true"
				is_link="false"
				is_update="true"
				;;
			link)
				is_install="false"
				is_link="true"
				is_update="false"
				;;
			--with-gui)
				with_gui="true"
				;;
			--all) ;;

			--verbose | --debug)
				set -x
				shift
				;;
			*)
				echo "[ERROR] Invalid arguments '${1}'"
				usage
				exit 1
				;;
		esac
		shift
	done

	# default behaviour
	if [[ "$is_install" == false && "$is_link" == false && "$is_update" == false ]]; then
		is_install="true"
		is_link="true"
		is_update="true"
	fi

	if [[ "$is_install" = true ]]; then
		source $current_dir/lib/dotsinstaller/install-required-packages.sh
	fi

	if [[ "$is_link" = true ]]; then
		source $current_dir/lib/dotsinstaller/link-to-homedir.sh
		source $current_dir/lib/dotsinstaller/gitconfig.sh
		print_info ""
		print_info "#####################################################"
		print_info "$(basename "${BASH_SOURCE[0]:-$0}") link success!!!"
		print_info "#####################################################"
		print_info ""
	fi

	if [[ "$is_update" = true ]]; then
		source $current_dir/lib/dotsinstaller/install-basic-packages.sh
		mkdir -p ~/.local/
		ln -snf $current_dir/lib/dotsinstaller/bin/* ~/.local/bin/

		if [[ "$with_gui" = true ]]; then
			source $current_dir/lib/dotsinstaller/install-extra.sh
			source $current_dir/lib/dotsinstaller/setup-terminal.sh
			# source $current_dir/lib/dotsinstaller/install-i3.sh
			# source $current_dir/lib/dotsinstaller/install-sway.sh
			source $current_dir/lib/dotsinstaller/install-hyprland.sh
			source $current_dir/lib/dotsinstaller/setup-default-app.sh
			source $current_dir/lib/dotsinstaller/install-font.sh
		fi

		print_info ""
		print_info "#####################################################"
		print_info "$(basename "${BASH_SOURCE[0]:-$0}") update finish!!!"
		print_info "#####################################################"
		print_info ""
	fi
}

main "$@"

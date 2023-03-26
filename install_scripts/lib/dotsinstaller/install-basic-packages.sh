#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

distro=$(whichdistro)
if [[ $distro == "redhat" ]]; then
	checkinstall zsh git tmux bc curl wget gawk python3-pip unzip sqlite sqlite-devel gettext procps jq
elif [[ $distro == "debian" ]]; then
	checkinstall zsh git tmux bc curl wget gawk python3-pip unzip sqlite3 gettext procps jq
else
	checkinstall zsh git tmux bc curl wget xsel gawk python-pip unzip sqlite gettext procps jq
fi

if [[ $distro == "redhat" ]]; then
	:
elif [[ $distro == "arch" ]]; then
	sudo pacman -S --noconfirm --needed tar
elif [[ $distro == "alpine" ]]; then
	sudo apk add g++
elif [[ $distro == "debian" ]]; then
	:
else
	:
fi

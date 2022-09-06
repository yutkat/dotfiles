#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/utilfuncs.sh

function install_sway() {
	local distro
	distro=$(whichdistro)
	if [[ $distro == "debian" ]]; then
		:
	elif [[ $distro == "redhat" ]]; then
		:
	elif [[ $distro == "arch" ]]; then
		sudo pacman -S --noconfirm --needed sway xorg-xwayland xorg-server-xwayland waybar swaylock swayidle swaybg wl-clipboard
		sudo pacman -S --noconfirm --needed pipewire xdg-desktop-portal xdg-desktop-portal-wlr
	elif [[ $distro == "alpine" ]]; then
		:
	fi
}
function install_run_script() {
	sudo tee /usr/local/bin/swayrun.sh <<"EOS" >/dev/null
#!/usr/bin/env bash
set -euo pipefail

# Export all variables
set -a
# Call the systemd generator that reads all files in environment.d
source /dev/fd/0 <<EOF
	$(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
EOF
set +a
exec sway
EOS
	sudo chmod +x /usr/local/bin/swayrun.sh
}

install_sway
install_run_script

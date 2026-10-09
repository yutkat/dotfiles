#!/usr/bin/env bash

set -eu

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Global variables
SINGLE_USER_MODE=false

# Logging functions
log_info() {
	echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
	echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
	echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
	echo -e "${RED}[ERROR]${NC} $1"
}

# NixOS needs nixos-rebuild; every other system gets Nix + Home Manager.
is_nixos() {
	[[ -f /etc/NIXOS ]]
}

# Check if command exists
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Download the Nix installer and run it; fail on HTTP errors or empty downloads
run_nix_installer() {
	local installer
	installer=$(mktemp)
	if ! curl -fsSL https://nixos.org/nix/install -o "$installer" || [[ ! -s "$installer" ]]; then
		rm -f "$installer"
		log_error "Failed to download the Nix installer"
		return 1
	fi
	local status=0
	sh "$installer" "$@" || status=$?
	rm -f "$installer"
	return "$status"
}

# Show help information
show_help() {
	echo "Usage: $0 [OPTIONS]"
	echo ""
	echo "OPTIONS:"
	echo "  --single       Install Nix in single-user mode (no daemon)"
	echo "  --help, -h     Show this help message"
	echo ""
	echo "Default behavior (no options):"
	echo "  Set up Nix environment for flake-based configurations (multi-user mode)"
	echo ""
	echo "Examples:"
	echo "  $0                 # Setup Nix environment (multi-user)"
	echo "  $0 --single        # Setup Nix environment (single-user)"
	echo "  $0 --help          # Show this help"
	echo ""
	echo "Single-user mode is recommended for:"
	echo "  • Docker containers"
	echo "  • Development environments"
	echo "  • Systems without systemd"
	echo "  • Non-root installations"
}

# Install Nix (multi-user)
install_nix_multiuser() {
	log_info "Installing Nix (multi-user mode)..."

	# Install Nix with daemon
	log_info "Running Nix installer with daemon..."
	if run_nix_installer --daemon --yes; then
		log_success "Nix installed successfully (multi-user)"

		# Source the profile for current session
		if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
			source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
			log_info "Nix profile sourced for current session"
		fi

		# Verify installation
		if command_exists nix; then
			nix --version
			log_success "Nix installation verified"
		else
			log_error "Nix installation completed but nix command not found"
			log_info "You may need to restart your shell"
			return 1
		fi
	else
		log_error "Nix installation failed"
		return 1
	fi
}

# Install Nix (single-user)
install_nix_singleuser() {
	log_info "Installing Nix (single-user mode)..."

	# Install Nix without daemon
	log_info "Running Nix installer without daemon..."
	if run_nix_installer --no-daemon --yes; then
		log_success "Nix installed successfully (single-user)"

		# Create initial profile if it doesn't exist
		if [[ ! -e "$HOME/.nix-profile" ]]; then
			log_info "Creating initial Nix profile..."
			/nix/var/nix/profiles/default/bin/nix-env -i
			log_info "Initial profile created"
		fi

		# Source the profile for current session
		if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
			source "$HOME/.nix-profile/etc/profile.d/nix.sh"
			log_info "Nix profile sourced for current session"
		else
			log_error "Nix profile not found at $HOME/.nix-profile/etc/profile.d/nix.sh"
			log_error "Initial profile creation may have failed"
			return 1
		fi

		# Add to shell profiles if not already there
		local shell_profiles=("$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile")
		local nix_source_line='if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi'

		for profile in "${shell_profiles[@]}"; do
			if [[ -f "$profile" ]] && ! grep -q "nix-profile/etc/profile.d/nix.sh" "$profile"; then
				echo "$nix_source_line" >>"$profile"
				log_info "Added Nix sourcing to $profile"
			fi
		done

		# Verify installation
		if command_exists nix; then
			nix --version
			log_success "Nix installation verified"
		else
			log_error "Nix installation completed but nix command not found"
			log_info "You may need to restart your shell or run: source ~/.nix-profile/etc/profile.d/nix.sh"
			return 1
		fi
	else
		log_error "Nix installation failed"
		return 1
	fi
}

# Install Nix (for non-NixOS systems)
install_nix() {
	log_info "Setting up Nix..."

	# Check if Nix is already installed
	if command_exists nix; then
		log_info "Using existing Nix installation ($(nix --version))"

		if [[ "$SINGLE_USER_MODE" == "false" ]]; then
			# For multi-user, ensure daemon is running
			if ! systemctl is-active --quiet nix-daemon 2>/dev/null; then
				log_info "Starting nix-daemon..."
				sudo -n systemctl start nix-daemon 2>/dev/null || log_warning "Could not start nix-daemon without a password; start it manually"
			fi

			# Source profile
			if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
				source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
				log_info "Nix profile sourced for current session"
			fi
		else
			# For single-user, just source profile
			if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
				source "$HOME/.nix-profile/etc/profile.d/nix.sh"
				log_info "Nix profile sourced for current session"
			fi
		fi
	elif [[ "$SINGLE_USER_MODE" == "true" ]]; then
		install_nix_singleuser
	else
		install_nix_multiuser
	fi
}

# Enable Nix flakes
enable_flakes() {
	log_info "Enabling Nix flakes..."

	# Create config directory
	mkdir -p ~/.config/nix

	# Enable experimental features
	if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
		echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf
		log_success "Flakes enabled in user config"
	else
		log_warning "Flakes already enabled in user config"
	fi

	# For multi-user mode, also enable system-wide if possible
	local root_command=()
	if [[ "$EUID" -ne 0 ]]; then
		root_command=(sudo)
	fi
	if [[ "$SINGLE_USER_MODE" == "false" ]] && ([[ "$EUID" -eq 0 ]] || sudo -n true 2>/dev/null); then
		"${root_command[@]}" mkdir -p /etc/nix
		if ! "${root_command[@]}" grep -q "experimental-features" /etc/nix/nix.conf 2>/dev/null; then
			echo "experimental-features = nix-command flakes" | "${root_command[@]}" tee -a /etc/nix/nix.conf >/dev/null
			log_success "Flakes enabled system-wide"
		else
			log_warning "Flakes already enabled system-wide"
		fi
	fi
}

# Setup for NixOS
setup_nixos() {
	log_info "Setting up Nix environment for NixOS..."

	if [[ "$SINGLE_USER_MODE" == "true" ]]; then
		log_warning "Single-user mode is not typical for NixOS systems"
		log_info "NixOS usually uses multi-user Nix installation"
	fi

	# Enable flakes
	enable_flakes

	log_success "NixOS environment setup complete!"
}

# Setup for non-NixOS systems
setup_standalone() {
	if [[ "$SINGLE_USER_MODE" == "true" ]]; then
		log_info "Setting up Nix environment (single-user mode)..."
	else
		log_info "Setting up Nix environment (multi-user mode)..."
	fi

	# Install Nix if not present
	install_nix

	# Enable flakes
	enable_flakes

	# Home Manager is not pre-installed: the first switch runs it from the
	# locked flake input, and the configuration then installs the command.

	if [[ "$SINGLE_USER_MODE" == "true" ]]; then
		log_success "Standalone Nix environment setup complete (single-user mode)!"
	else
		log_success "Standalone Nix environment setup complete (multi-user mode)!"
	fi
}

# Display usage instructions
show_usage_instructions() {
	local os_type="$1"
	local hostname=${HOSTNAME}

	log_info ""
	log_info "=== Next Steps ==="

	case "$os_type" in
	"nixos")
		log_info "For NixOS system configuration:"
		log_info "  sudo nixos-rebuild switch --flake .#$hostname"
		log_info ""
		log_info "To link dotfiles:"
		log_info "  mise trust"
		log_info "  mise bootstrap dotfiles apply"
		log_info ""
		log_info "To install mise tools and run setup tasks:"
		log_info "  mise run setup"
		log_info ""
		log_info "To see available configurations:"
		log_info "  nix flake show"
		log_info ""
		log_info "To update flake inputs:"
		log_info "  nix flake update"
		;;
	*)
		log_info "For Home Manager configuration (first run; later just 'home-manager switch'):"
		log_info "  # Default user:"
		log_info "  nix run --inputs-from . home-manager -- switch --flake .#$hostname"
		log_info ""
		log_info "  # Custom username:"
		log_info "  NIX_USERNAME=your_username nix run --inputs-from . home-manager -- switch --impure --flake .#$hostname"
		log_info ""
		log_info "To link dotfiles:"
		log_info "  mise trust"
		log_info "  mise bootstrap dotfiles apply"
		log_info ""
		log_info "To install mise tools and run setup tasks:"
		log_info "  mise run setup"
		log_info ""
		log_info "To see available configurations:"
		log_info "  nix flake show"
		log_info ""
		log_info "To update flake inputs:"
		log_info "  nix flake update"
		log_info ""
		log_info "Useful commands:"
		log_info "  home-manager generations           # Show previous generations"
		log_info "  nix-collect-garbage -d             # Clean up old packages"
		;;
	esac

	log_info ""
	if [[ "$SINGLE_USER_MODE" == "true" ]]; then
		log_info "If you encounter 'command not found' errors, try:"
		log_info "  source ~/.nix-profile/etc/profile.d/nix.sh"
	else
		log_info "If you encounter 'command not found' errors, try:"
		log_info "  source ~/.nix-profile/etc/profile.d/hm-session-vars.sh"
	fi
	log_info "Or restart your terminal session."
}

# Main function
main() {
	# Parse command line arguments
	case "${1:-}" in
	--single)
		SINGLE_USER_MODE=true
		log_info "Single-user mode selected"
		;;
	--help | -h)
		show_help
		exit 0
		;;
	"")
		# Default behavior - setup (multi-user)
		;;
	*)
		log_error "Unknown option: $1"
		show_help
		exit 1
		;;
	esac

	log_info "Starting Nix environment setup..."

	# Change to script directory
	cd "$(dirname "$0")"

	# Check if flake.nix exists
	if [[ ! -f "flake.nix" ]]; then
		log_error "flake.nix not found in current directory"
		exit 1
	fi

	if is_nixos; then
		log_info "Detected NixOS"
		setup_nixos
		show_usage_instructions "nixos"
	else
		log_info "Detected a non-NixOS system"
		setup_standalone
		show_usage_instructions "standalone"
	fi
	log_success "Nix environment setup completed successfully!"
	log_info "You can now apply your configurations using the commands shown above."
}

# Run main function
main "$@"

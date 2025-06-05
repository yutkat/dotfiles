#!/usr/bin/env bash

set -e

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

# Detect OS
detect_os() {
    if [[ -f /etc/NIXOS ]]; then
        echo "nixos"
    elif [[ -d /nix/store ]] && command_exists nix; then
        echo "nixos-container"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    elif [[ -f /etc/debian_version ]]; then
        echo "debian"
    elif [[ -f /etc/redhat-release ]]; then
        echo "redhat"
    else
        echo "unknown"
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Show help information
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  --single       Install Nix in single-user mode (no daemon)"
    echo "  --uninstall    Completely uninstall Nix and remove dead symlinks"
    echo "  --help, -h     Show this help message"
    echo ""
    echo "Default behavior (no options):"
    echo "  Set up Nix environment for flake-based configurations (multi-user mode)"
    echo ""
    echo "Examples:"
    echo "  $0                 # Setup Nix environment (multi-user)"
    echo "  $0 --single        # Setup Nix environment (single-user)"
    echo "  $0 --uninstall     # Uninstall Nix and cleanup"
    echo "  $0 --help          # Show this help"
    echo ""
    echo "Single-user mode is recommended for:"
    echo "  • Docker containers"
    echo "  • Development environments"
    echo "  • Systems without systemd"
    echo "  • Non-root installations"
}

# Remove dead symlinks
remove_dead_symlinks() {
    local directories=("$@")

    log_info "Removing dead symlinks from home directories..."

    for dir in "${directories[@]}"; do
        if [[ -d "$dir" ]]; then
            log_info "Checking for dead symlinks in: $dir"

            # Find and remove dead symlinks
            local dead_links=$(find "$dir" -type l ! -exec test -e {} \; -print 2>/dev/null || true)

            if [[ -n "$dead_links" ]]; then
                echo "$dead_links" | while IFS= read -r link; do
                    if [[ -n "$link" ]]; then
                        log_info "Removing dead symlink: $link"
                        rm -f "$link"
                    fi
                done
                log_success "Dead symlinks removed from $dir"
            else
                log_info "No dead symlinks found in $dir"
            fi
        else
            log_info "Directory does not exist: $dir"
        fi
    done
}

# Uninstall Nix (multi-user)
uninstall_nix_multiuser() {
    log_info "Uninstalling Nix (multi-user mode)..."

    # Try to use nix-installer uninstall if available
    if [[ -x /nix/nix-installer ]]; then
        log_info "Using nix-installer for clean uninstall..."
        if sudo /nix/nix-installer uninstall; then
            log_success "Nix uninstalled successfully using nix-installer"
            return 0
        else
            log_warning "nix-installer failed, falling back to manual method"
        fi
    fi

    # Manual multi-user uninstall
    log_info "Performing manual multi-user uninstall..."

    # Stop daemon
    if systemctl is-active --quiet nix-daemon 2>/dev/null; then
        sudo systemctl stop nix-daemon
        sudo systemctl disable nix-daemon
        log_success "Nix daemon stopped and disabled"
    fi

    # Remove systemd files
    sudo rm -f /etc/systemd/system/nix-daemon.service
    sudo rm -f /etc/systemd/system/nix-daemon.socket
    sudo rm -f /etc/systemd/system/multi-user.target.wants/nix-daemon.service
    sudo systemctl daemon-reload

    # Remove nixbld users
    for i in $(seq 1 32); do
        if id "nixbld$i" &>/dev/null; then
            sudo userdel "nixbld$i"
            log_info "Removed user nixbld$i"
        fi
    done

    if getent group nixbld &>/dev/null; then
        sudo groupdel nixbld
        log_success "Removed group nixbld"
    fi

    # Remove Nix store
    sudo rm -rf /nix
    log_success "Nix store removed"

    # Clean system profiles
    local system_profiles=(
        "/etc/bashrc"
        "/etc/profile.d/nix.sh"
        "/etc/zshrc"
        "/etc/bash.bashrc"
        "/etc/zsh/zshrc"
    )

    for profile in "${system_profiles[@]}"; do
        if [[ -f "$profile" ]]; then
            sudo sed -i.bak-before-nix-removal '/nix/d' "$profile" 2>/dev/null || true
            log_info "Cleaned $profile"
        fi
    done

    # Remove backup files
    sudo rm -f /etc/bash.bashrc.backup-before-nix
    sudo rm -f /etc/bashrc.backup-before-nix  
    sudo rm -f /etc/profile.backup-before-nix
    sudo rm -f /etc/zsh/zshrc.backup-before-nix
    sudo rm -f /etc/zshrc.backup-before-nix
}

# Uninstall Nix (single-user)
uninstall_nix_singleuser() {
    log_info "Uninstalling Nix (single-user mode)..."

    # Remove Nix store (user-owned)
    rm -rf /nix 2>/dev/null || {
        log_warning "Could not remove /nix (may need sudo for some files)"
        sudo rm -rf /nix
    }
    log_success "Nix store removed"
}

# Common user cleanup for both modes
cleanup_user_files() {
    log_info "Cleaning up user-specific Nix files..."

    # User profiles
    local user_profiles=(
        "$HOME/.bash_profile"
        "$HOME/.bashrc" 
        "$HOME/.profile"
        "$HOME/.zshrc"
    )

    for profile in "${user_profiles[@]}"; do
        if [[ -f "$profile" ]]; then
            sed -i.bak-before-nix-removal '/nix/d' "$profile" 2>/dev/null || true
            log_info "Cleaned $profile"
        fi
    done

    # User Nix files
    rm -rf "$HOME/.nix-channels" 2>/dev/null || true
    rm -rf "$HOME/.nix-defexpr" 2>/dev/null || true
    rm -rf "$HOME/.nix-profile" 2>/dev/null || true
    rm -rf "$HOME/.config/nix" 2>/dev/null || true
    rm -rf "$HOME/.config/nixpkgs" 2>/dev/null || true
    rm -rf "$HOME/.cache/nix" 2>/dev/null || true
    rm -rf "$HOME/.local/state/nix" 2>/dev/null || true

    log_success "User Nix files removed"
}

# Complete uninstall
complete_uninstall() {
    log_info "Starting complete Nix uninstallation and cleanup..."

    # Detect installation mode
    if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]] || systemctl list-unit-files | grep -q nix-daemon; then
        log_info "Detected multi-user Nix installation"
        uninstall_nix_multiuser
    elif [[ -d /nix ]] && [[ -O /nix ]] 2>/dev/null; then
        log_info "Detected single-user Nix installation"
        uninstall_nix_singleuser
    elif [[ -d /nix ]]; then
        log_warning "Nix installation detected but mode unclear, trying both methods"
        uninstall_nix_multiuser 2>/dev/null || uninstall_nix_singleuser
    else
        log_info "No Nix installation detected"
    fi

    # Common cleanup
    cleanup_user_files

    # Remove dead symlinks
    log_info "Cleaning up dead symlinks..."
    remove_dead_symlinks "$HOME" "$HOME/.config"

    log_success "Complete uninstallation finished!"
    log_info "All Nix components and dead symlinks have been removed."
    log_info "You may want to restart your shell or logout/login to complete the cleanup."
}

# Clean install of Nix (multi-user)
clean_install_nix_multiuser() {
    log_info "Performing clean Nix installation (multi-user mode)..."

    # Install Nix with daemon
    log_info "Running Nix installer with daemon..."
    if sh <(curl -L https://nixos.org/nix/install) --daemon; then
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

# Clean install of Nix (single-user)
clean_install_nix_singleuser() {
    log_info "Performing clean Nix installation (single-user mode)..."

    # Install Nix without daemon
    log_info "Running Nix installer without daemon..."
    if sh <(curl -L https://nixos.org/nix/install) --no-daemon; then
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
                echo "$nix_source_line" >> "$profile"
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
        log_info "Nix is already installed ($(nix --version))"

        # Ask user if they want to reinstall
        read -p "Would you like to reinstall Nix for a clean setup? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            complete_uninstall
            if [[ "$SINGLE_USER_MODE" == "true" ]]; then
                clean_install_nix_singleuser
            else
                clean_install_nix_multiuser
            fi
        else
            log_info "Using existing Nix installation"

            if [[ "$SINGLE_USER_MODE" == "false" ]]; then
                # For multi-user, ensure daemon is running
                if ! systemctl is-active --quiet nix-daemon 2>/dev/null; then
                    log_info "Starting nix-daemon..."
                    sudo systemctl start nix-daemon 2>/dev/null || true
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
        fi
    else
        # Fresh installation
        if [[ "$SINGLE_USER_MODE" == "true" ]]; then
            clean_install_nix_singleuser
        else
            clean_install_nix_multiuser
        fi
    fi
}

# Enable Nix flakes
enable_flakes() {
    log_info "Enabling Nix flakes..."

    # Create config directory
    mkdir -p ~/.config/nix

    # Enable experimental features
    if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
        echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
        log_success "Flakes enabled in user config"
    else
        log_warning "Flakes already enabled in user config"
    fi

    # For multi-user mode, also enable system-wide if possible
    if [[ "$SINGLE_USER_MODE" == "false" ]] && ([[ -w /etc/nix ]] || sudo -n true 2>/dev/null); then
        sudo mkdir -p /etc/nix
        if ! sudo grep -q "experimental-features" /etc/nix/nix.conf 2>/dev/null; then
            echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf > /dev/null
            log_success "Flakes enabled system-wide"
        else
            log_warning "Flakes already enabled system-wide"
        fi
    fi
}

# Install Home Manager (standalone)
install_home_manager_standalone() {
    log_info "Installing Home Manager (standalone)..."

    # Check if Home Manager is already installed
    if command_exists home-manager; then
        log_warning "Home Manager is already installed"
        home-manager --version

        # Update channels anyway
        log_info "Updating existing Home Manager channels..."
        nix-channel --update home-manager 2>/dev/null || true
        return 0
    fi

    # Add Home Manager channel if not exists
    if ! nix-channel --list | grep -q home-manager; then
        log_info "Adding Home Manager channel..."
        nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
        log_success "Home Manager channel added"
    else
        log_warning "Home Manager channel already exists"
    fi

    # Update channels
    log_info "Updating Nix channels..."
    nix-channel --update

    # Install Home Manager
    log_info "Installing Home Manager..."
    if nix-shell '<home-manager>' -A install; then
        log_success "Home Manager installed successfully"

        # Verify installation
        if command_exists home-manager; then
            home-manager --version
            log_success "Home Manager installation verified"
        else
            log_warning "Home Manager installation completed but command not found"
            log_info "You may need to restart your shell or source the profile"
        fi
    else
        log_error "Home Manager installation failed"
        return 1
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

    # Check if flake.nix is valid
    log_info "Validating flake configuration..."
    if nix flake check --no-build 2>/dev/null; then
        log_success "Flake configuration is valid"
    else
        log_warning "Flake configuration has issues (this might be normal)"
    fi

    # Show available configurations
    log_info "Available NixOS configurations:"
    nix flake show 2>/dev/null | grep -E "nixosConfigurations" -A 10 || log_warning "Could not display configurations"

    log_success "NixOS environment setup complete!"
}

# Setup for NixOS container (nixos/nix Docker image)
setup_nixos_container() {
    log_info "Setting up Nix environment for NixOS container..."

    # In containers, Nix is already installed and configured
    # We just need to enable flakes and validate configuration

    # Enable flakes
    enable_flakes

    # Skip Home Manager installation in container mode - not needed for testing
    log_info "Skipping Home Manager installation in container mode"

    # Check if flake.nix is valid
    log_info "Validating flake configuration..."
    if nix flake check --no-build 2>/dev/null; then
        log_success "Flake configuration is valid"
    else
        log_warning "Flake configuration has issues (this might be normal)"
    fi

    # Show available configurations
    log_info "Available configurations:"
    nix flake show 2>/dev/null || log_warning "Could not display configurations"
    install_home_manager_standalone

    log_success "NixOS container environment setup complete!"
}

# Setup for non-NixOS systems
setup_standalone() {
    local os_type="$1"

    if [[ "$SINGLE_USER_MODE" == "true" ]]; then
        log_info "Setting up Nix environment for $os_type (single-user mode)..."
    else
        log_info "Setting up Nix environment for $os_type (multi-user mode)..."
    fi

    # Install Nix if not present
    install_nix

    # Enable flakes
    enable_flakes

    # Install Home Manager
    install_home_manager_standalone

    # Check if flake.nix is valid
    log_info "Validating flake configuration..."
    if nix flake check --no-build 2>/dev/null; then
        log_success "Flake configuration is valid"
    else
        log_warning "Flake configuration has issues (this might be normal)"
    fi

    # Show available configurations
    log_info "Available Home Manager configurations:"
    nix flake show 2>/dev/null | grep -E "homeConfigurations" -A 10 || log_warning "Could not display configurations"

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
            log_info "To see available configurations:"
            log_info "  nix flake show"
            log_info ""
            log_info "To update flake inputs:"
            log_info "  nix flake update"
            ;;
        *)
            log_info "For Home Manager configuration:"
            log_info "  # Default user:"
            log_info "  home-manager switch --flake .#$hostname"
            log_info ""
            log_info "  # Custom username:"
            log_info "  NIX_USERNAME=your_username home-manager switch --flake .#$hostname"
            log_info ""
            log_info "  # Custom dotfiles path:"
            log_info "  NIX_DOTFILES_PATH=/path/to/dotfiles home-manager switch --flake .#$hostname"
            log_info ""
            log_info "  # Both custom username and path:"
            log_info "  NIX_USERNAME=kata NIX_DOTFILES_PATH=/custom/path home-manager switch --flake .#$hostname"
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
        --uninstall)
            log_info "Uninstall mode selected"

            # Show what will be uninstalled
            log_info ""
            log_info "=== UNINSTALL CONFIRMATION ==="
            log_info "This will completely remove:"
            log_info "• Nix package manager and all its components"
            log_info "• All Nix store contents (/nix directory)"
            log_info "• Nix daemon and systemd services (if multi-user)"
            log_info "• nixbld users and group (if multi-user)"
            log_info "• Nix-related shell profile modifications"
            log_info "• User-specific Nix files and caches"
            log_info "• Dead symlinks in ~ and ~/.config directories"
            log_info ""
            log_warning "This action cannot be undone!"
            log_info ""

            # Confirm uninstallation
            read -p "Do you really want to proceed with complete Nix uninstallation? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                log_info "Proceeding with uninstallation..."
                complete_uninstall
            else
                log_info "Uninstallation cancelled by user"
                log_info "No changes were made to your system"
            fi
            exit 0
            ;;
        --help|-h)
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

    # Detect OS
    local os_type="$(detect_os)"
    log_info "Detected OS: $os_type"

    # Change to script directory
    cd "$(dirname "$0")"

    # Check if flake.nix exists
    if [[ ! -f "flake.nix" ]]; then
        log_error "flake.nix not found in current directory"
        exit 1
    fi

    case "$os_type" in
        "nixos")
            if setup_nixos; then
                show_usage_instructions "$os_type"
                log_success "Nix environment setup completed successfully!"
                log_info "You can now apply your configurations using the commands shown above."
            else
                log_error "NixOS setup failed"
                exit 1
            fi
            ;;
        "nixos-container")
            if setup_nixos_container; then
                show_usage_instructions "nixos"
                log_success "Nix environment setup completed successfully!"
                log_info "Container setup complete - ready for testing."
            else
                log_error "NixOS container setup failed"
                exit 1
            fi
            ;;
        "arch"|"debian"|"redhat"|"unknown")
            if setup_standalone "$os_type"; then
                show_usage_instructions "$os_type"
                log_success "Nix environment setup completed successfully!"
                log_info "You can now apply your configurations using the commands shown above."
            else
                log_error "Standalone setup failed"
                exit 1
            fi
            ;;
        *)
            log_error "Unsupported OS: $os_type"
            exit 1
            ;;
    esac
}

# Run main function
main "$@"

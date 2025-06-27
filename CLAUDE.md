# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a comprehensive dotfiles repository for NixOS/Nix systems with multi-host support:

- **Flake-based configuration**: Uses `flake.nix` with host-specific configurations
- **Multi-host support**: Supports both NixOS systems and standalone Home Manager installations
- **Modular structure**: Separate CLI and GUI configurations in home-manager/
- **Host-specific configs**: Per-host overrides in nixos/hosts/ and home-manager/hosts/
- **Environment variable support**: NIX_USERNAME and NIX_DOTFILES_PATH for customization
- **Symlink management**: Uses `mkOutOfStoreSymlink` for live-editable configurations

### Key Configuration Files

- `flake.nix`: Main configuration defining hosts and build functions
- `home.nix`: Home Manager entry point with symlink management
- `home-manager/cli.nix`: CLI tools and terminal configurations
- `home-manager/gui.nix`: GUI applications and desktop environment
- `nixos/configuration.nix`: Base NixOS system configuration

### Current Hosts

- `lemp10`: Full NixOS system with GUI (default user: yutkat)
- `X1C10`: Standalone Home Manager only (default user: kata)
- `test`: Minimal test configuration
- `system-test`: Full system for testing
- `container`: Container-specific configuration

## Commands

### Installation & Setup

- Install Nix environment: `./install.sh` (add `--single` for single-user mode)
- Apply NixOS config: `sudo nixos-rebuild switch --flake .#hostname`
- Apply Home Manager config: `home-manager switch --flake .#hostname`
- Update zsh plugins: `exec zsh`
- Update neovim plugins: `vi --headless -c 'Lazy! sync' -c 'qall'`

### Development & Testing

- Validate flake: `nix flake check`
- Show available configurations: `nix flake show`
- Update flake inputs: `nix flake update`
- Custom username: `NIX_USERNAME=user home-manager switch --flake .#hostname --impure`
- Custom dotfiles path: `NIX_DOTFILES_PATH=/path home-manager switch --flake .#hostname --impure`

### Code Quality & Linting

- Validate flake: `nix flake check`
- Neovim benchmark: `/usr/bin/time --format="%e" nvim --headless -c "qall"`
- Lua linting: Uses Selene (config in selene.toml)
- Lua formatting: Uses Stylua (config in .stylua.toml)  
- Spell checking: Uses cSpell (config in .cspell.json)

## Code Style Guidelines

### Shell Scripts

- Start with shebang: `#!/usr/bin/env bash`
- Use strict mode: `set -ue` or `set -Eeuo pipefail`
- Function syntax: `function name() {}`
- Variables: snake_case, always quoted `"${variable}"`
- Error handling: Use traps for cleanup
- Prefer local variables with `local` keyword
- Handle errors with informative messages

### Nix Files

- Use consistent indentation (2 spaces)
- Group imports logically
- Use let-in blocks for complex expressions
- Comment complex attribute paths
- Follow nixpkgs contribution guidelines

### Lua (Neovim)

- Follow neovim global standards defined in neovim.yml
- Tests use describe/it/before_each/after_each structure
- Allow multiple statements and mixed tables per selene.toml

## Development Patterns

### Configuration Management

- **Live Configuration**: Files in `.config/` are symlinked, not copied to Nix store
- **Host-Specific Overrides**: Use `hosts/hostname.nix` files for per-host customization
- **Conditional Modules**: GUI modules only load when `enableGui = true`
- **Environment Variables**: Support `NIX_USERNAME` and `NIX_DOTFILES_PATH` for flexibility

### Testing Configurations

- Use `test` or `system-test` hosts for experimentation
- Test NixOS changes: `sudo nixos-rebuild switch --flake .#system-test`
- Test Home Manager: `home-manager switch --flake .#test`
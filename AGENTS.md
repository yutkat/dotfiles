# Repository Guidelines

## Project Structure & Module Organization

- **Nix flake**: `flake.nix`, `flake.lock` — entry point for all hosts.
- **System configs**: `nixos/` (per-host under `nixos/hosts/<host>/configuration.nix`).
- **Home Manager**: `home.nix`, `home-manager/` (optional per-host `home-manager/hosts/<host>.nix`).
- **Dotfiles**: under `.config/`, plus top-level files like `.zshenv`, `.xprofile`, `.xinitrc`.
- **Scripts**: `install.sh` (bootstrap), `.github/` (CI, lint, benchmark).

## Build, Test, and Development Commands

- **Bootstrap (all OS)**: `./install.sh` — installs Nix, flake support, Home Manager.
- **Apply (NixOS)**: `sudo nixos-rebuild switch --flake .#<host>`.
- **Apply (others)**: `home-manager switch --flake .#<host>`.
- **Neovim plugins**: `nvim --headless -c "Lazy! sync" -c "qall"`.
- **Lint shell**: `find . -name "*.sh" -print0 | xargs -0 shellcheck`.
- **Lint Lua**: `selene -q .`.
- **Format Nix**: `nixfmt --check $(git ls-files '*.nix')` (use RFC-style).

## Coding Style & Naming Conventions

- **Shell**: POSIX/Bash; keep scripts non-interactive, `set -eu`; pass shellcheck.
- **Lua (Neovim)**: 2‑space indent (`.editorconfig`), lint with Selene; optional format with Stylua.
- **Nix**: RFC-style via `nixfmt`; small modules over monoliths.
- **Hosts**: Name as in `flake.nix` `myHosts` (e.g., `nixos/hosts/X1C10/`, `home-manager/hosts/lemp10.nix`).
- **Files**: Prefer declarative links via `home.nix` over ad‑hoc symlinks.

## Testing Guidelines

- **CI parity**: Run the same checks locally as `.github/workflows/lint.yml`.
- **Shell**: `shellcheck` must report no errors (allowances in CI are for edge cases only).
- **Lua**: `selene` must be clean; add tests/health checks for critical plugins when feasible.
- **Nix**: Validate eval/build: `nix flake check` (if targets are provided) and a dry run apply where possible.

## Commit & Pull Request Guidelines

- **Commits**: Small, focused; prefer Conventional Commits (e.g., `feat(nvim): add snacks.nvim`).
- **Messages**: Imperative subject, include context/scope; avoid committing generated files.
- **PRs**: Include purpose, screenshots for UI tweaks, and notes for new hosts. Update `flake.nix` `myHosts` and add `nixos/hosts/<host>/` or `home-manager/hosts/<host>.nix` as needed. Link related issues.

## Security & Configuration Tips

- Never commit secrets; use environment variables or Nix options. Tags are GPG‑signed by default via shared git config. Prefer changes that keep reproducible builds and fast shell/Neovim startup (see benchmarks in CI).

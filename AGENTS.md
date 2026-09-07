# Repository Guidelines

## Layout and Ownership

- `flake.nix` defines hosts; system configuration lives in `nixos/`, Home Manager in `home.nix` and `home-manager/`, and dotfiles in `.config/` and top-level shell files.
- Standalone CLI binaries belong in mise `[tools]` in `.config/mise/config.toml`; Nix/Home Manager owns shells, user services, toolchains, and libraries.
- Manage links through mise `[dotfiles]`, with sources relative to `.config/mise/config.toml`; the `"~/.config/*"` glob covers new config directories.
- When adding a host, update `flake.nix` `myHosts` and the matching `nixos/hosts/<host>/configuration.nix` or `home-manager/hosts/<host>.nix`.
- Home Manager uses `useGlobalPkgs = false`, so its overlays do not affect NixOS system packages.

## Development

- See `README.md` for installation and apply commands, and `.config/mise/tasks/lint` for the exact lint commands used by CI.
- Apply dotfile links with `mise dotfiles apply`; after CLI tool changes, regenerate zsh completions with `mise run zsh-completions-sync`.
- Follow local formatting and `.editorconfig`; Nix uses RFC-style nixfmt, shell scripts use POSIX/Bash with `set -eu` and remain non-interactive.
- Preserve reproducible builds and fast shell/Neovim startup; benchmarks live in `.github/`.
- Prefer Conventional Commit subjects; PRs should explain the change and verification, with screenshots for UI changes and notes for new hosts.

## Verification

- After any repository change, run `mise run lint` and do not report completion until it passes.
- If cache or sandbox restrictions block lint, retry with the required approval; report any remaining blocker instead of claiming completion.
- For Nix changes, evaluate/build the affected target before applying; run `nix flake check` when checks are available and a dry run apply where possible.

---
paths:
  - "**/*.nix"
  - "**/flake.lock"
---

# Nix

## No Reflexive Workarounds

Nix errors name a precise cause. Find it before changing anything; never apply an
escape hatch just to silence the message. If only an escape hatch works, say why
the proper fix is unavailable and get agreement first.

Do not do these unasked:

- `--impure`, sandbox off, `NIXPKGS_ALLOW_*`, `allowUnfree` / `allowBroken` /
  `permittedInsecurePackages`.
- `lib.mkForce` instead of finding the module that sets the conflicting value.
- `doCheck = false` / `dontCheck*` to force a build through.
- Placeholder hashes left in the tree, or a hash pasted from an error without
  checking the source is the intended one.
- Bare `nix flake update`; update one input with `nix flake update <input>`.
- Hand-editing or deleting `flake.lock`, or deleting `result` / store paths.
- Raw `home.file` / `writeShellScriptBin` when the module has an option for it.
- Deleting or commenting out the failing configuration.

## `nixpkgs.overlays` Is a Last Resort

An overlay rewrites the attribute for every consumer. Stop at the first step that
works, and state what you ruled out before proposing step 4:

1. The existing module option (`settings`, `extraConfig`, `extraArgs`, env var).
2. `pkgs.<x>.override { ... }` scoped in a `let`.
3. That override assigned to `programs.<x>.package` / `services.<x>.package`.
4. An overlay — only if other packages' closures must pick up the change.

Prefer `.override` over `.overrideAttrs`. Overriding low in the tree (`glibc`,
`openssl`, `python3`) voids the binary cache and rebuilds the world; warn first.
This flake sets `useGlobalPkgs = false`, so a Home Manager overlay does not reach
the NixOS system.

## Verification

- Build before switching: `nixos-rebuild build` / `home-manager build`.
- Isolate eval errors with `nix eval` on the specific attribute.
- If a command cannot run here, report it unverified; do not swap in `--impure`
  and call it passing.

---
paths:
  - "**/*.nix"
  - "**/flake.lock"
---

# Nix

- Diagnose the failing attribute with `nix eval` before changing configuration; do not remove failing configuration just to pass a build.
- Ask before introducing workarounds such as `--impure`, disabling the sandbox, `NIXPKGS_ALLOW_*`, `allowUnfree`, `allowBroken`, `permittedInsecurePackages`, `lib.mkForce`, or disabled build checks (`doCheck = false` / `dontCheck*`); explain why a direct fix is unavailable.
- Update only intended inputs with `nix flake update <input>`; do not hand-edit/delete `flake.lock` or delete `result`/store paths unless requested.
- Verify the intended source before accepting a hash from an error; do not leave placeholder hashes.
- Prefer existing module options over `home.file`/`writeShellScriptBin`, then scoped package overrides assigned to `programs.<x>.package` or `services.<x>.package`; explain why those are insufficient before using an overlay for changes needed by other consumers.
- Prefer `.override` over `.overrideAttrs`; warn before changing foundational packages such as `glibc`, `openssl`, or `python3` because of broad rebuilds.
- Build before switching with `nixos-rebuild build` or `home-manager build`; report blocked verification without substituting `--impure` and calling it passing.

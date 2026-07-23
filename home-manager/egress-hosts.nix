# Canonical egress allowlist hosts. Each entry allows the host itself and all
# of its subdomains.
#
# `shared` hosts must also be present in the Claude Code sandbox allowlist
# (.config/claude/settings.json, sandbox.network.allowedDomains); the
# `egress-allowlist-sync` flake check enforces that. `nvimExtra` hosts are
# used only by the Neovim tinyproxy sandbox (home-manager/security.nix).
{
  shared = [
    "github.com"
    "githubusercontent.com"
    "githubcopilot.com"
    "anthropic.com"
    "registry.npmjs.org"
    "pypi.org"
    "files.pythonhosted.org"
    "crates.io"
  ];
  nvimExtra = [
    "wakapi.dev"
    "wakatime.com"
    "proxy.golang.org"
  ];
}

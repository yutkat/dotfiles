{
  pkgs,
  config,
  lib,
  inputs,
  username,
  ...
}:

{
  home.packages = with pkgs; [
    gcc
    gnumake
    nodejs
    file
    zip
    unzip
    eza
    wakatime-cli
    mise
    direnv
    nix-direnv
    translate-shell
    gh
    ghq
    zoxide
    ripgrep
    delta
    tldr
    trashy
    bat
    fd
    procs
    mmv-go
    fzf
    sqlite
    jq
    vale
    zsh
    wget
    rustc
    cargo
    bun
    node-gyp-build
  ];
  programs = {
    gpg = {
      enable = true;
    };
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
    defaultCacheTtl = 604800;
    maxCacheTtl = 604800;
  };
  # Locate the dotfiles checkout through the mise-managed ~/.zshenv link so
  # the path is never hardcoded; skip silently before the first
  # `mise dotfiles apply`.
  home.activation.valeSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    zshenv_target="$(readlink -f "$HOME/.zshenv" 2>/dev/null || true)"
    if [ -n "$zshenv_target" ]; then
      dotfiles_path="$(dirname "$zshenv_target")"
      if [ -f "$dotfiles_path/.vale.ini" ]; then
        (cd "$dotfiles_path" && ${pkgs.vale}/bin/vale sync)
      fi
    fi
  '';
}

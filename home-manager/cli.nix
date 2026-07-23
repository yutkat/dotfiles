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
    yq-go
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
}

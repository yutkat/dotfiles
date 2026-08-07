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
    wakatime-cli
    mise
    direnv
    nix-direnv
    translate-shell
    sqlite
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

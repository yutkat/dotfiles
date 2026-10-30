{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    gnumake
    nodejs
    file
    zip
    unzip
    direnv
    nix-direnv
    zsh
    nushell
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

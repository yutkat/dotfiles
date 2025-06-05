{ pkgs, config, lib, inputs, username, ... }:

let
  pythonEnv = pkgs.python3.withPackages
    (ps: with ps; [ build installer wheel setuptools pip poetry-core ]);
in {
  nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
  home.packages = with pkgs; [
    gcc
    gnumake
    nodejs
    deno
    zip
    unzip
    eza
    wakatime-cli
    mise
    direnv
    translate-shell
    gh
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
  ];
  programs = {
    neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    };
    zsh = { enable = true; };
    gpg = { enable = true; };
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
    defaultCacheTtl = 604800;
    maxCacheTtl = 604800;
  };
}

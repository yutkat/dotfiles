{ pkgs, config, lib, inputs, username, ... }:

{
  nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
  home.packages = with pkgs; [
    git
    zsh
    neovim
    gcc
    gnumake
    python3
    python3Packages.installer
    python3Packages.build
    python3Packages.wheel
    python3Packages.setuptools
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
  };
}

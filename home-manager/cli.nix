{ pkgs, config, lib, inputs, username, ... }:

{
  nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
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
    jq
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

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
    nodePackages.node-gyp-build
  ];
  programs = {
    neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    };
    gpg = { enable = true; };
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
    defaultCacheTtl = 604800;
    maxCacheTtl = 604800;
  };
  home.activation.valeSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    dotfiles_path="${config.home.homeDirectory}/dotfiles"
    if [ -f "$dotfiles_path/.vale.ini" ]; then
      (cd "$dotfiles_path" && ${pkgs.vale}/bin/vale sync)
    fi
  '';
}

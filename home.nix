{
  lib,
  enableGui,
  ...
}:
{
  imports = [
    ./home-manager/cli.nix
    ./home-manager/security.nix
  ]
  ++ (lib.optionals enableGui [ ./home-manager/gui.nix ]);

  # Dotfile symlinks are managed by mise (see [dotfiles] in mise.toml);
  # apply them with `mise bootstrap dotfiles apply`.

  home = {
    stateVersion = "25.05";
  };
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}

{
  lib,
  enableGui,
  hostSpecificHomeConfig ? null,
  ...
}:
{
  imports = [
    ./home-manager/cli.nix
    ./home-manager/security.nix
  ]
  ++ (lib.optionals enableGui [ ./home-manager/gui.nix ])
  ++ (lib.optionals (hostSpecificHomeConfig != null) [ hostSpecificHomeConfig ]);

  # Dotfile symlinks are managed by mise (see [dotfiles] in mise.toml);
  # apply them with `mise bootstrap dotfiles apply`.

  home = {
    stateVersion = "25.05";
    activation.reloadUserSystemd = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      $DRY_RUN_CMD systemctl --user daemon-reload || true
    '';
  };
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}

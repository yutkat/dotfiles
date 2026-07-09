{
  pkgs,
  config,
  lib,
  username,
  enableGui,
  hostSpecificHomeConfig ? null,
  ...
}:
let
  # Fix the libsqlite.so not found issue for https://github.com/kkharji/sqlite.lua.
  libsqlitePath = import ./home-manager/lib/libsqlite.nix pkgs;
in
{
  imports = [
    ./home-manager/cli.nix
    ./home-manager/security.nix
  ]
  ++ (lib.optionals enableGui [ ./home-manager/gui.nix ])
  ++ (lib.optionals (hostSpecificHomeConfig != null) [ hostSpecificHomeConfig ]);

  # Dotfile symlinks are managed by mise (see [dotfiles] in .config/mise/config.toml);
  # apply them with `mise dotfiles apply`.

  home = {
    username = username;
    homeDirectory = if username == "root" then "/root" else "/home/${username}";
    stateVersion = "25.05";
    file = {
      ".local/bin/x-terminal-emulator" = {
        source =
          if enableGui then
            lib.getExe pkgs.wezterm
          else
            config.lib.file.mkOutOfStoreSymlink "/usr/bin/wezterm";
        force = true;
      };
      ".local/bin/x-www-browser" = {
        source =
          if enableGui then
            lib.getExe pkgs.vivaldi
          else
            config.lib.file.mkOutOfStoreSymlink "/usr/bin/vivaldi";
        force = true;
      };
    };
    activation.GitConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.git}/bin/git config --global include.path "${config.home.homeDirectory}/.config/git/gitconfig_shared"
    '';
    activation.reloadUserSystemd = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      $DRY_RUN_CMD systemctl --user daemon-reload || true
    '';
    sessionVariables = {
      LIBSQLITE = libsqlitePath;
    };
  };
  systemd.user.sessionVariables = {
    LIBSQLITE = libsqlitePath;
  };
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}

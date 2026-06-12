{
  pkgs,
  config,
  lib,
  inputs,
  username,
  enableGui,
  hostSpecificHomeConfig ? null,
  ...
}:
let
  envDotfilesPath = builtins.getEnv "NIX_DOTFILES_PATH";
  dotfilesPath =
    if envDotfilesPath != "" then envDotfilesPath else "${config.home.homeDirectory}/dotfiles";
in
{
  imports = [
    inputs.dotfile-symlinks.homeManagerModules.default
    ./home-manager/cli.nix
    ./home-manager/security.nix
  ]
  ++ (lib.optionals enableGui [ ./home-manager/gui.nix ])
  ++ (lib.optionals (hostSpecificHomeConfig != null) [ hostSpecificHomeConfig ]);

  dotfiles.symlinks = {
    enable = true;
    path = dotfilesPath;
    sourceRoot = ./.;
    directories = [
      {
        source = ".config";
        ignore = [
          "systemd"
          "environment.d"
        ];
      }
      { source = ".config/environment.d"; }
    ];
    files = {
      ".xinitrc".source = ".xinitrc";
      ".xprofile".source = ".xprofile";
      ".zshenv".source = ".zshenv";
      ".claude".source = ".config/claude";
      ".codex".source = ".config/codex";
    };
  };

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
    sessionVariables = {
      # Fix the libsqlite.so not found issue for https://github.com/kkharji/sqlite.lua.
      LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
    };
  };
  systemd.user.sessionVariables = {
    # Fix the libsqlite.so not found issue for https://github.com/kkharji/sqlite.lua.
    LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
  };
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}

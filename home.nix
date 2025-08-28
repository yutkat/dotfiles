{ pkgs, config, lib, inputs, username, enableGui, hostSpecificHomeConfig ? null
, ... }:
let
  # Read dotfiles path from environment variable, fallback to default
  dotfilesPath = let envDotfiles = builtins.getEnv "NIX_DOTFILES_PATH";
  in if envDotfiles != "" then
    envDotfiles
  else
    "${config.home.homeDirectory}/dotfiles";

  mkLink = { lib, builtins, sourcePathRoot, ignoreList ? [ ] }:
    let
      dirContents = builtins.readDir ./${sourcePathRoot};
      entriesList =
        lib.attrsets.mapAttrsToList (name: type: { inherit name type; })
        dirContents;
      mappedList = lib.lists.map ({ name, type }:
        if (lib.lists.any (pattern: pattern == name) ignoreList) then
          null
        else {
          name = "${sourcePathRoot}/${name}";
          value = {
            source = config.lib.file.mkOutOfStoreSymlink
              "${dotfilesPath}/${sourcePathRoot}/${name}";
            recursive = (type == "directory");
          };
        }) entriesList;
    in builtins.listToAttrs (lib.lists.filter (x: x != null) mappedList);
  configFiles = mkLink {
    inherit lib builtins;
    sourcePathRoot = ".config";
    ignoreList = [ "systemd" "environment.d" ];
  };
  # systemdFiles = mkLink {
  #   inherit lib builtins;
  #   sourcePathRoot = ".config/systemd/user";
  #   ignoreList = [ ];
  # };
  environmentdFiles = mkLink {
    inherit lib builtins;
    sourcePathRoot = ".config/environment.d";
    ignoreList = [ ];
  };
in {
  imports = [ ./home-manager/cli.nix ]
    ++ (lib.optionals enableGui [ ./home-manager/gui.nix ])
    ++ (lib.optionals (hostSpecificHomeConfig != null)
      [ hostSpecificHomeConfig ]);
  home = {
    username = username;
    homeDirectory = if username == "root" then "/root" else "/home/${username}";
    stateVersion = "25.05";
    file = configFiles // environmentdFiles // {
      ".xinitrc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.xinitrc";
        force = true;
      };
      ".xprofile" = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.xprofile";
        force = true;
      };
      ".zshenv" = {
        source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.zshenv";
        force = true;
      };
      ".claude" = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/claude";
        force = true;
      };
      ".codex" = {
        source =
          config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/.config/codex";
        force = true;
      };
      ".local/bin/x-terminal-emulator" = {
        source = if enableGui then
          lib.getExe pkgs.wezterm
        else
          config.lib.file.mkOutOfStoreSymlink "/usr/bin/wezterm";
        force = true;
      };
      ".local/bin/x-www-browser" = {
        source = if enableGui then
          lib.getExe pkgs.vivaldi
        else
          config.lib.file.mkOutOfStoreSymlink "/usr/bin/vivaldi";
        force = true;
      };
    };
    activation.GitConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.git}/bin/git config --global include.path "${config.home.homeDirectory}/.config/git/gitconfig_shared"
    '';
  };
  systemd.user.sessionVariables = {
    # Fix the libsqlite.so not found issue for https://github.com/kkharji/sqlite.lua.
    LD_LIBRARY_PATH =
      "${pkgs.lib.makeLibraryPath (with pkgs; [ sqlite ])}:$LD_LIBRARY_PATH";
  };
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}

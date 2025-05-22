{ pkgs, config, lib, inputs, username, enableGui, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  mkLink= { lib, builtins, sourcePathRoot, ignoreList ? [] }:
    let
      dirContents = builtins.readDir ./${sourcePathRoot};
      entriesList = lib.attrsets.mapAttrsToList (name: type: { inherit name type; }) dirContents;
      mappedList = lib.lists.map ({ name, type }:
        if (lib.lists.any (pattern: pattern == name) ignoreList)
        then null
        else {
          name = "${sourcePathRoot}/${name}";
          value = {
            source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${sourcePathRoot}/${name}";
            recursive = (type == "directory");
          };
        }
      ) entriesList;
    in
      builtins.listToAttrs (lib.lists.filter (x: x != null) mappedList);

  configFiles = mkLink { inherit lib builtins; sourcePathRoot = ".config"; ignoreList = ["systemd" "environment.d"];};
  systemdFiles = mkLink { inherit lib builtins; sourcePathRoot = ".config/systemd/user"; ignoreList = [];};
  environmentdFiles = mkLink { inherit lib builtins; sourcePathRoot = ".config/environment.d"; ignoreList = [];};

in
{
  imports = [
    ./home-manager/cli.nix
  ] ++ (lib.optionals enableGui [
    ./home-manager/gui.nix
  ]);
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";

    file =
      configFiles //
      systemdFiles //
      environmentdFiles //
      {
        ".xinitrc" = {
          source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.xinitrc";
          force = true;
        };
        ".xprofile" = {
          source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.xprofile";
          force = true;
        };
        ".zshenv" = {
          source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/.zshenv";
          force = true;
        };
        ".local/bin/x-terminal-emulator" = {
          source = lib.getExe pkgs.wezterm;
          force = true;
        };
        ".local/bin/x-www-browser" = {
          source = lib.getExe pkgs.vivaldi;
          force = true;
        };
      };

    activation.GitConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.git}/bin/git config --global include.path "${config.home.homeDirectory}/.config/git/gitconfig_shared"
    '';
  };
  systemd.user.sessionVariables = {
    # Fix the libsqlite.so not found issue for https://github.com/kkharji/sqlite.lua.
    LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath (with pkgs; [ sqlite ])}:$LD_LIBRARY_PATH";
  };

  programs.home-manager.enable = true;
}

{ pkgs, config, lib, inputs, username, ... }:

{
  nixpkgs.overlays = [
    # Vivaldi overlay
    (final: prev: {
      vivaldi = let
        vivaldiFlagsFileContent =
          builtins.readFile ../.config/vivaldi-stable.conf;
        vivaldiFlagsList = let
          lines = lib.strings.splitString "\n" vivaldiFlagsFileContent;
          trimmedLines = lib.map lib.strings.trim lines;
          nonEmptyLines = lib.filter (s: s != "") trimmedLines;
          validFlags =
            lib.filter (s: !(lib.strings.hasPrefix "#" s)) nonEmptyLines;
        in validFlags;
        vivaldiCommandLineStringFromFile =
          lib.strings.concatStringsSep " " vivaldiFlagsList;
      in prev.vivaldi.override {
        commandLineArgs = vivaldiCommandLineStringFromFile;
      };
    })
  ];

  home.packages = with pkgs; [
    vivaldi
    wezterm
    nordzy-cursor-theme
    waybar
    walker
    wl-clipboard-rs
    hyprpaper
    dunst
    libnotify
    copyq
    hypridle
    hyprlock
    grim
    slurp
    pyprland
    brightnessctl
    adwaita-icon-theme
    arc-theme
    comixcursors
    gnome-themes-extra
    papirus-icon-theme
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = false;
  };

  fonts.fontconfig = { enable = false; };

}

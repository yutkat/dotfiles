{ pkgs, config, lib, inputs, username, ... }:

let
  pythonEnv = pkgs.python3.withPackages
    (ps: with ps; [ build installer wheel setuptools pip poetry-core ]);
in {
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
    wl-clipboard
    cliphist
    hyprpaper
    dunst
    libnotify
    hypridle
    hyprlock
    grim
    slurp
    swappy
    pyprland
    pythonEnv
    brightnessctl
    adwaita-icon-theme
    arc-theme
    comixcursors
    gnome-themes-extra
    papirus-icon-theme
  ];
  home.sessionPath = [ "${pythonEnv}/bin" ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = false;
  };

  fonts.fontconfig = { enable = false; };

}

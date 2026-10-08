{
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.overlays = [
    # Vivaldi overlay
    (final: prev: {
      vivaldi =
        let
          vivaldiFlagsFileContent = builtins.readFile ../.config/vivaldi-stable.conf;
          vivaldiFlagsList =
            let
              lines = lib.strings.splitString "\n" vivaldiFlagsFileContent;
              trimmedLines = lib.map lib.strings.trim lines;
              nonEmptyLines = lib.filter (s: s != "") trimmedLines;
              validFlags = lib.filter (s: !(lib.strings.hasPrefix "#" s)) nonEmptyLines;
            in
            validFlags;
          vivaldiCommandLineStringFromFile = lib.strings.concatStringsSep " " vivaldiFlagsList;
        in
        prev.vivaldi.override {
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
    elephant
    wl-clipboard
    cliphist
    hyprpaper
    dunst
    libnotify
    hypridle
    hyprlock
    grim
    grimblast
    slurp
    swappy
    pyprland
    brightnessctl
    adwaita-icon-theme
    comixcursors
    gnome-themes-extra
    pulseaudio
  ];

  fonts.fontconfig = {
    enable = false;
  };

}

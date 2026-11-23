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
    gnome-themes-extra
    pulseaudio
  ];

  fonts.fontconfig = {
    enable = false;
  };

  systemd.user.services.elephant = {
    Unit = {
      Description = "Elephant data provider daemon for Walker";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.elephant}/bin/elephant";
      ExecSearchPath = "%h/.nix-profile/bin:/etc/profiles/per-user/%u/bin:/run/current-system/sw/bin:%h/.local/bin:/usr/local/bin:/usr/bin:/bin";
      Environment = [
        "PATH=%h/.nix-profile/bin:/etc/profiles/per-user/%u/bin:/run/current-system/sw/bin:%h/.local/bin:/usr/local/bin:/usr/bin:/bin"
        "XDG_DATA_DIRS=%h/.nix-profile/share:/etc/profiles/per-user/%u/share:/run/current-system/sw/share:/usr/local/share:/usr/share"
      ];
      Restart = "always";
      RestartSec = 1;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
      UpheldBy = [ "graphical-session.target" ];
    };
  };

}

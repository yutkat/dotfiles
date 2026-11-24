# Desktop user services for every host. enableGui only decides whether Nix
# installs the GUI stack; hosts without it (e.g. Arch) may still run the same
# desktop from distro packages, so binaries are resolved via ExecSearchPath.
{
  systemd.user.services.elephant = {
    Unit = {
      Description = "Elephant data provider daemon for Walker";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "elephant";
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

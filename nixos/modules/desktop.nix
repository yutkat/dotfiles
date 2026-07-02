{
  config,
  pkgs,
  username,
  ...
}:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.seatd.enable = false;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${config.programs.regreet.package}/bin/regreet";
        user = "greeter";
      };
      initial_session = {
        #command = "${pkgs.dbus}/bin/dbus-run-session ${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
        command = "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
        user = username;
      };
    };
  };
  programs.regreet = {
    enable = true;
    settings = {
      #background = {
      #  path =
      #    ../.config/hypr/wallpaper/Simple-Minimalist-Wallpaper-2560x1600-64817.jpg;
      #  fit = "Cover";
      #};

      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "Adwaita";
        font_name = "Cantarell 16";
        icon_theme_name = "Adwaita";
        theme_name = "Adwaita";
      };

      commands = {
        reboot = [
          "systemctl"
          "reboot"
        ];
        poweroff = [
          "systemctl"
          "poweroff"
        ];
      };

      cageArgs = [
        "-m"
        "last"
      ];
      extraCss = builtins.readFile ./regreet.css;
    };
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}

{
  pkgs,
  username,
  ...
}:

{
  # Hyprland is Wayland-only (XWayland covers X11 apps); keep the defaults
  # services.xserver.enable used to provide.
  services.libinput.enable = true;
  gtk.iconCache.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session.user = "greeter";
      initial_session = {
        command = "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
        user = username;
      };
    };
  };
  services.displayManager.regreet = {
    enable = true;
    settings = {
      GTK.application_prefer_dark_theme = true;

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
    };
    cageArgs = [
      "-s"
      "-d"
      "-m"
      "last"
    ];
    extraCss = ./regreet.css;
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Also used for the console keymap and XWayland
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}

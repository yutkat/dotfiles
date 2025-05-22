{ pkgs, config, lib, inputs, username, ... }:

{
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

  fonts.fontconfig = {
    enable = false;
  };

}

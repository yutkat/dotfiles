{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  services.udev.extraHwdb = builtins.readFile ../../../system-etc/udev/hwdb.d/90-keyboard-layout.hwdb;
  environment.systemPackages = with pkgs; [ system76-firmware ];
}

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  services.udev.extraHwdb =
    builtins.readFile ../../../system-etc/udev/hwdb.d/90-keyboard-layout.hwdb;
  environment.systemPackages = with pkgs; [ system76-firmware ];
  # boot.initrd.kernelModules = [ "i915" ];
  boot.kernelParams = [
    "i915.enable_fbc=1"
    "i915.enable_guc=3"
    "acpi_osi=Linux"
    "usbcore.autosuspend=-1"
  ];
  hardware.system76.enableAll = true;
  # hardware.system76.power-daemon.enable = true;
  # services.system76-scheduler.enable = true;
  # services.hardware.bolt.enable = true;
}

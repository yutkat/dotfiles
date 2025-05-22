{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  services.udev.extraHwdb = ''
    # Custom key mappings for System76 Lemur (lemp10)
    evdev:input:*v0001p*eAB83*
     KEYBOARD_KEY_3a=leftctrl
     KEYBOARD_KEY_36=tab
     KEYBOARD_KEY_0f=pause
     KEYBOARD_KEY_b7=insert
     KEYBOARD_KEY_9d=esc
  '';
}

{ config, lib, pkgs, inputs, username, hostname, ... }:

let
  sqliteClibPath =
    "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
in
{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  # boot.kernelPackages = pkgs.linuxPackages_lts;

  networking.hostName = hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Isolated, uplink-less bridge: the only egress path for sandboxed Neovim
  # (snvim --net=nvbr0). The sandbox reaches tinyproxy on 10.123.45.1; a firejail
  # netfilter drops everything else. No uplink/NAT -- the proxy egresses as a
  # normal host process. See docs/superpowers/specs/2026-06-09-neovim-runtime-sandbox-design.md
  networking.networkmanager.unmanaged = [ "interface-name:nvbr0" ];
  networking.firewall.trustedInterfaces = [ "nvbr0" ];
  systemd.services.nvbr0 = {
    description = "Isolated bridge for sandboxed Neovim egress";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-pre.target" ];
    before = [ "network.target" ];
    path = [ pkgs.iproute2 ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ip link show nvbr0 >/dev/null 2>&1 || ip link add nvbr0 type bridge
      ip addr replace 10.123.45.1/24 dev nvbr0
      ip link set nvbr0 up
    '';
    preStop = "ip link del nvbr0";
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [ fcitx5-mozc fcitx5-gtk fcitx5-nord ];
    };
  };

  fonts = {
    packages = (with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      fira-code
      fira-code-symbols
      dina-font
      proggyfonts
      udev-gothic-nf
      font-awesome
      cantarell-fonts
    ]);

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "UDEV Gothic 35NFLG" ];
        sansSerif = [ "Noto Sans CJK JP" "DejaVu Sans" ];
        serif = [ "Noto Serif JP" "DejaVu Serif" ];
      };
      subpixel = { lcdfilter = "light"; };
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.seatd.enable = false;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.cage}/bin/cage -s -- ${config.programs.regreet.package}/bin/regreet";
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
        reboot = [ "systemctl" "reboot" ];
        poweroff = [ "systemctl" "poweroff" ];
      };

      cageArgs = [ "-m" "last" ];
      extraCss = ''
        window {
          background: #11111b;
          color: #cdd6f4;
        }

        window.background {
          background: #11111b;
        }

        box {
          background: transparent;
        }

        entry,
        button,
        combobox,
        popover {
          background: #181825;
          color: #cdd6f4;
        }

        entry selection {
          background: #45475a;
          color: #cdd6f4;
        }

        button:hover {
          background: #313244;
        }

        label {
          color: #cdd6f4;
        }
      '';
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

  services.locate.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.fwupd.enable = true;

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "video" "input" "podman" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  # programs.firefox.enable = true;
  programs.firejail.enable = true;
  programs.zsh.enable = true;
  programs.git.enable = true;
  # https://nix.dev/guides/faq#how-to-run-non-nix-executables
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ icu ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ nix-index ];
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  environment.etc."xdg/uwsm/env".text = ''
    export LIBSQLITE=${sqliteClibPath}
  '';

  system.stateVersion = "25.11";

  nix = { settings = { experimental-features = [ "nix-command" "flakes" ]; }; };
}

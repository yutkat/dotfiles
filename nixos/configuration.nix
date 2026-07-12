{
  pkgs,
  username,
  hostname,
  ...
}:

let
  sqliteClibPath = import ../home-manager/lib/libsqlite.nix pkgs;
in
{
  imports = [
    ./modules/audio.nix
    ./modules/desktop.nix
    ./modules/fonts.nix
    ./modules/i18n.nix
    ./modules/nvim-sandbox.nix
    ./modules/virtualisation.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  # boot.kernelPackages = pkgs.linuxPackages_lts;

  networking.hostName = hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  services.locate.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.fwupd.enable = true;

  security.polkit.enable = true;
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "podman"
    ];
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

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}

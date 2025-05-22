{
  description = "My NixOS configurations for multiple hosts using Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, neovim-nightly-overlay, ... }@inputs:
  let
    username = "yutkat";

    myHosts = {
      "lemp10" = {
        system = "x86_64-linux";
        hostSpecificNix = ./nixos/hosts/lemp10/configuration.nix;
        enableGui = true;
        enableSystem = true;
      };
      "X1C10" = {
        system = "x86_64-linux";
        hostSpecificNix = ./nixos/hosts/X1C10/configuration.nix;
        enableGui = false;
        enableSystem = false;
      };
    };

    vivaldiFlagsFileContent = builtins.readFile ./.config/vivaldi-stable.conf;
    vivaldiFlagsList =
      let
        lib = nixpkgs.lib;
        lines = lib.strings.splitString "\n" vivaldiFlagsFileContent;
        trimmedLines = lib.map lib.strings.trim lines;
        nonEmptyLines = lib.filter (s: s != "") trimmedLines;
        validFlags = lib.filter (s: !(lib.strings.hasPrefix "#" s)) nonEmptyLines;
      in
        validFlags;

    vivaldiCommandLineStringFromFile = nixpkgs.lib.strings.concatStringsSep " " vivaldiFlagsList;
    vivaldiOverlay = final: prev: {
      vivaldi = prev.vivaldi.override {
        commandLineArgs = vivaldiCommandLineStringFromFile;
      };
    };

    mkNixosSystem = hostname: hostAttrs:
      let
        system = hostAttrs.system;
        specialArgs = {
          inherit inputs username hostname; 
          enableGui = hostAttrs.enableGui;
        };
      in
      nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ({ pkgs, lib, ... }: {
            nixpkgs.overlays = [
              neovim-nightly-overlay.overlays.default 
              vivaldiOverlay
            ];
          })

          ./nixos/configuration.nix
          hostAttrs.hostSpecificNix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home.nix;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.backupFileExtension = "hm-backup";
          }
        ];
      };

  in {
    nixosConfigurations = nixpkgs.lib.mapAttrs mkNixosSystem myHosts;
  };
}

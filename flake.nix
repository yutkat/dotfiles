{
  description = "My NixOS configurations for multiple hosts using Flakes";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      myHosts = {
        "lemp10" = {
          system = "x86_64-linux";
          hostSpecificNix = ./nixos/hosts/lemp10/configuration.nix;
          enableGui = true;
          enableSystem = true;
          defaultUsername = "yutkat";
        };
        "X1C10" = {
          system = "x86_64-linux";
          hostSpecificNix = ./nixos/hosts/X1C10/configuration.nix;
          enableGui = false;
          enableSystem = false;
          defaultUsername = "kata";
        };
        "test" = {
          system = "x86_64-linux";
          enableGui = false;
          enableSystem = false;
          defaultUsername = "test";
        };
        "system-test" = {
          system = "x86_64-linux";
          enableGui = true;
          enableSystem = true;
          defaultUsername = "test";
          hostSpecificNix = { };
        };
        "container" = {
          system = "x86_64-linux";
          enableGui = false;
          enableSystem = false;
          defaultUsername = "root";
        };
      };
      # Read username from environment variable, fallback to default
      getUsernameForHost = hostname: hostAttrs:
        let
          envUser = builtins.getEnv "NIX_USERNAME";
          hostDefaultUser = hostAttrs.defaultUsername;
        in if envUser != "" then envUser else hostDefaultUser;

      # NixOS system configuration builder function
      mkNixosSystem = hostname: hostAttrs:
        let
          system = hostAttrs.system;
          username = getUsernameForHost hostname hostAttrs;
          specialArgs = {
            inherit inputs hostname username;
            enableGui = hostAttrs.enableGui;
          };
        in nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ({ pkgs, lib, ... }: { })
            ./nixos/configuration.nix
            hostAttrs.hostSpecificNix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./home.nix;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.backupFileExtension = "hm-backup";
            }
          ];
        };

      # Home Manager standalone configuration builder function (for Arch Linux, etc.)
      mkHomeManagerConfiguration = hostname: hostAttrs:
        let
          system = hostAttrs.system;
          username = getUsernameForHost hostname hostAttrs;
          pkgs = import nixpkgs { inherit system; };
          specialArgs = {
            inherit inputs username hostname;
            enableGui = hostAttrs.enableGui;
          };
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = specialArgs;
        };

      # Classify hosts based on enableSystem flag
      nixosHosts =
        nixpkgs.lib.filterAttrs (name: attrs: attrs.enableSystem) myHosts;
      homeManagerHosts =
        nixpkgs.lib.filterAttrs (name: attrs: !attrs.enableSystem) myHosts;

    in {
      # NixOS configurations (enableSystem = true)
      nixosConfigurations = nixpkgs.lib.mapAttrs mkNixosSystem nixosHosts;

      # Home Manager standalone configurations (enableSystem = false, for Arch Linux, etc.)
      # Username can be specified via NIX_USERNAME environment variable
      # Usage:
      #   home-manager switch --flake .#X1C10  (uses default username: yutkat)
      #   NIX_USERNAME=kat home-manager switch --flake .#X1C10 --impure  (uses kat)
      homeConfigurations = nixpkgs.lib.mapAttrs' (hostname: hostAttrs:
        nixpkgs.lib.nameValuePair hostname
        (mkHomeManagerConfiguration hostname hostAttrs)) homeManagerHosts;
    };
}

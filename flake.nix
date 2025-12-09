{
  description = "Anrzej NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/latest";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
      home-manager,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        formatter = pkgs.nixpkgs-fmt;
      }
    )
    // {
      nixosConfigurations = {
        # T490 configuration (current machine)
        anrzej-t490 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/t490
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.anrzej = import ./home/home.nix;
            }
          ];
          specialArgs = {
            flatpaks = inputs.flatpaks;
          };
        };

        # P14s configuration
        anrzej-p14s = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/p14s
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.anrzej = {
                imports = [
                  inputs.plasma-manager.homeManagerModules.plasma-manager
                  ./home/home.nix
                ];
              };
            }
          ];
          specialArgs = {
            flatpaks = inputs.flatpaks;
          };
        };

        # Server configuration
        anrzej-serwer = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/serwer
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.anrzej-serwer= {
                imports = [
                  inputs.plasma-manager.homeManagerModules.plasma-manager
                  ./home/home.nix
                ];
              };
            }
          ];
          specialArgs = {
            flatpaks = inputs.flatpaks;
          };
        };
      };
    };
}

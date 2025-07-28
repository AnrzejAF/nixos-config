{
  description = "Anrzej NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/stable-v3";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, home-manager, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        formatter = pkgs.nixpkgs-fmt;
      }
    ) // {
      nixosConfigurations.anrzej-nix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/hardware-configuration.nix
          ./common/common.nix
          ./hosts/anrzej-user.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.anrzej = import ./home/home.nix;
          }
        ];

        specialArgs = { flatpaks = inputs.flatpaks; };
      };
    };
}

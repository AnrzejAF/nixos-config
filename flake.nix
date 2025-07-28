{
  description = "NixOS configuration without Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/stable-v3";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
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
        ];

        specialArgs = { flatpaks = inputs.flatpaks; };
      };
    };
}

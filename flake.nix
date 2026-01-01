{
  description = "Anrzej NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-flatpak,
      home-manager,
      ...
    } : 
    {
      nixosConfigurations = {
        # P14s configuration
        anrzej-p14s = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
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
        };

        # Server configuration
        anrzej-serwer = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
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
        };
      };
    };
}

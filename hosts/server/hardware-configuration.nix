# Hardware configuration for server - to be generated with nixos-generate-config
{
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # This will be replaced with actual hardware configuration
  # Run: sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
  
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
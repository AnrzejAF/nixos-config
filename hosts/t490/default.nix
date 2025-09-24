{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/common.nix
    ../../users/anrzej.nix
  ];

  networking.hostName = "anrzej-t490";
  
  # T490-specific configuration
  # This is the current laptop configuration
}
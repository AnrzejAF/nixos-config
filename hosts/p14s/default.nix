{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/common.nix
    ../../users/anrzej.nix
  ];

  networking.hostName = "anrzej-p14s";
  
  # P14s-specific configuration
  # Example: different graphics drivers, power management, etc.
  # This will be customized based on P14s hardware
}
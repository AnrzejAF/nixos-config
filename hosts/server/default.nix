{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/common.nix
    ../../users/anrzej.nix
  ];

  networking.hostName = "anrzej-server";
  
  # Server-specific configuration
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  
  # Disable GUI components for server
  services.xserver.enable = lib.mkForce false;
  services.displayManager.sddm.enable = lib.mkForce false;
  services.desktopManager.plasma6.enable = lib.mkForce false;
  programs.steam.enable = lib.mkForce false;
  programs.kdeconnect.enable = lib.mkForce false;
}
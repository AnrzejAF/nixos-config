{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/common.nix
    ../../users/anrzej-serwer.nix
  ];

  networking.hostName = "anrzej-serwer";

  hardware.enableAllFirmware = true;

  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_25;
    daemon.settings = {
      features = {
        cdi = true;
      };
    };
  };

  # Conservative kernel param copied from p14s for consistent sleep policy
  boot.kernelParams = [ "mem_sleep_default=deep" ];
}

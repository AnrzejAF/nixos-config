{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/common.nix
    ../../users/anrzej.nix
  ];

  networking.hostName = "anrzej-p14s";

  hardware.enableAllFirmware = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    modesetting.enable = true;
    powerManagement.enable = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_25; 
    daemon.settings = {
      features = {
        cdi = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
    efitools
  ];

  services.thermald.enable = true;

  services.power-profiles-daemon.enable = true;

  services.logind.lidSwitch = "hibernate";
  services.logind.lidSwitchExternalPower = "hibernate";
  services.logind.lidSwitchDocked = "ignore";

  # Enable energy savings during sleep
  boot.kernelParams = [ "mem_sleep_default=deep" ];
}

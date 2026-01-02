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
  
  powerManagement.enable = true;

  services.thermald.enable = true;

  services.power-profiles-daemon.enable = true;

  services.logind.settings.Login.HandleLidSwitch = "hibernate";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "hibernate";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";

  # Enable energy savings during sleep
  boot.kernelParams = [ "mem_sleep_default=deep" ];
}

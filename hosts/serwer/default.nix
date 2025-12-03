{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/common.nix
    ../../users/serwer.nix
  ];

  networking.hostName = "anrzej-server";

  # Keep firmware and container tooling like on p14s, but avoid desktop and
  # developer-specific packages. The user is separate and lighter (see
  # ../../users/serwer.nix).
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

  # Keep a minimal set of system packages for a server host
  environment.systemPackages = with pkgs; [ htop tmux ];

  # No X11 / GPU / thermald / desktop-specific services here — server should be
  # lean. Other settings can be added later if needed.
}
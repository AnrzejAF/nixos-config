{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";

  programs.ssh = {
    enable = true;
    forwardAgent = true;
  };
}

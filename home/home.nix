{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      IdentityFile ~/.ssh/nix_anrzej_t490
    '';
  };
}

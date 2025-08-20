{ config, pkgs, ... }:

{
  
  nix.settings.trusted-users = [ "root" "anrzej" ];

  users.users.anrzej = {
    isNormalUser = true;
    description = "anrzej";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "docker"
    ];

    shell = pkgs.zsh;

    packages = with pkgs; [
      # kde packages
      kdePackages.kate
      kdePackages.krfb

      # editor
      vscode
      stow

      # browser
      brave

      # nix formatter and linter
      nil
      nixfmt-rfc-style

      # CAD and 3D
      freecad
      orca-slicer

      # latex
      texliveFull
      corefonts

      # vpn
      protonvpn-gui

      # development
      nodejs_24
      devenv

      # streaming
      stremio
      yt-dlp

      # player
      mpv
      ffmpeg

      # xorg 
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
    ];
  };

  programs.kdeconnect.enable = true;

  programs.zsh.enable = true;

  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      IdentityFile ~/.ssh/nix_anrzej_t490
    '';
  };

  programs.git = {
    enable = true;
    config = {
      user.name = "Anrzej";
      user.email = "andrzejfijalo@gmail.com";
      init.defaultBranch = "main";
      core.editor = "nano";
      color.ui = "auto";
      pull.rebase = true;
    };
  };
}

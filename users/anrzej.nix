{ pkgs, ... }:

{
  nix.settings.trusted-users = [
    "root"
    "anrzej"
  ];

  users.users.anrzej = {
    isNormalUser = true;
    description = "anrzej";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "docker"
      "plugdev"
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
      xorg.xhost

      # steam
      protonup-qt

      libsndfile
      libsamplerate
      SDL2
      SDL2_mixer
      timidity

      zlib

      ultrastardx

      qbittorrent

      wine

      nmap

      duf

      btop

      usbutils
      findutils

      cachix
    ];
  };

  programs.nix-ld.enable = true;
  programs.kdeconnect.enable = true;
  programs.steam.enable = true;
  virtualisation.docker.enable = true;
  programs.zsh.enable = true;
  hardware.graphics.enable = true;
  
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
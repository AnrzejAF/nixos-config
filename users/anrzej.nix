{ pkgs, ... }:

{
  # Nix settings
  nix.settings.trusted-users = [
    "root"
    "anrzej"
  ];

  # User groups
  users.groups.plugdev = { };

  # User configuration
  users.users.anrzej = {
    isNormalUser = true;
    description = "anrzej";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "docker"
      "plugdev"
    ];

    packages = with pkgs; [
      # Development tools
      vscode
      nodejs_24
      devenv
      nil
      nixfmt-rfc-style
      git
      stow
      cachix
      inkscape

      # Desktop applications
      brave
      kdePackages.kate
      kdePackages.krfb
      protonvpn-gui

      # Media and entertainment
      mpv
      ffmpeg
      # stremio
      yt-dlp
      qbittorrent
      heroic
      ultrastardx

      # CAD and 3D printing
      freecad
      orca-slicer

      # LaTeX and documentation
      texliveFull
      corefonts

      # Gaming
      # protonup-qt
      wine

      # System utilities
      btop
      duf
      nmap
      usbutils
      findutils

      # Audio libraries
      libsndfile
      libsamplerate
      SDL2
      SDL2_mixer
      timidity

      # X11 libraries
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
      xorg.xhost

      # Other libraries
      zlib
    ];
  };

  programs.partition-manager.enable = true;

  # System programs and services
  programs.nix-ld.enable = true;
  programs.kdeconnect.enable = true;
  programs.steam.enable = true;
  programs.zsh.enable = true;

  # Hardware
  hardware.graphics.enable = true;

  # Virtualization
  virtualisation.docker.enable = true;

  # SSH configuration
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      IdentityFile ~/.ssh/nix_anrzej_t490
    '';
  };

  # Git configuration
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

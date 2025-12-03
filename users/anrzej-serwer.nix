{ pkgs, ... }:

{
  # Nix settings: trust the server user for limited operations
  nix.settings.trusted-users = [ "root" "anrzej-serwer" ];

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = "anrzej-serwer";

  # Minimal user groups
  users.groups.plugdev = { };

  users.users.anrzej-serwer = {
    isNormalUser = true;
    description = "Anrzej";
    extraGroups = [ "networkmanager" "wheel" ];

    # Minimal set of per-user packages for server usage
    packages = with pkgs; [
      htop
      tmux
      openssh
      vscode
      stremio
      brave
    ];
  };

  # Minimal program/service toggles for a headless server
  programs.zsh.enable = true;
  programs.ssh.startAgent = false;

  # Docker is enabled globally in the host config; keep the user in the docker group
  virtualisation.docker.enable = true;

  # Don't enable desktop-specific services on server
  programs.kdeconnect.enable = true;
  programs.steam.enable = false;
  programs.git.enable = false;


  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;
}

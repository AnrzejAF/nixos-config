{
  config,
  pkgs,
  flatpaks,
  ...
}:
let
  secretsPath = ../secrets/secrets.nix;
  secrets =
    if builtins.pathExists secretsPath then import secretsPath else { zerotier.networkId = ""; };
in
{
  imports = [ flatpaks.nixosModule ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";
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

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  console.keyMap = "pl2";

  services.printing.enable = true;

  programs.xwayland.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Luxonis udev rules for camera
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="03e7", ATTR{idProduct}=="f63b", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="03e7", ATTR{idProduct}=="2485", MODE="0666", GROUP="plugdev"
  '';
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-gpu-tools
      intel-media-driver
      intel-compute-runtime-legacy1
      intel-vaapi-driver
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    nano
    btop
    unzip
    file
    tree
  ];

  services.flatpak = {
    enable = true;
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };
    packages = [
      "flathub:app/app.zen_browser.zen//stable"
      "flathub:app/org.telegram.desktop//stable"
      "flathub:app/org.deskflow.deskflow//stable"
      "flathub:app/com.usebottles.bottles//stable"
    ];
    onCalendar = "daily";
  };

  hardware.i2c.enable = true; # Needed for ddcutil
  hardware.bluetooth.enable = true;
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  services.zerotierone = {
    enable = true;
    port = 9993;
    joinNetworks = [ secrets.zerotier.networkId ];
  };

  system.stateVersion = "25.05";
}

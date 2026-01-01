{ pkgs, lib, ... }:

{
  # User
  users.users.anrzej-serwer = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [ htop tmux openssh vscode brave stremio git zerotierone];
  };

  # Open SSH port in the firewall
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Enable the SSH daemon (server)
  services.openssh = {
    enable = true;

    # Optional but recommended:
    # Disable root login via password
    permitRootLogin = "no";

    # Disable password auth (use keys)
    passwordAuthentication = true;
  };

  services.zerotierone.enable = true;


  # Enable full GUI
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

 # services.vscode-server.enable = true;

  # Flatpak portals for GUI apps
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    kdePackages.xdg-desktop-portal-kde
  ];

  programs.nix-ld.enable = true;

  services.flatpak.enable = true;
  services.flatpak.packages = [
    "org.deskflow.deskflow"
    "com.stremio.Stremio"
  ];
  
# Headless tools (still useful)
  programs.zsh.enable = true;
  programs.ssh.startAgent = true;
  virtualisation.docker.enable = true;

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;

  # Locale
  i18n.defaultLocale = lib.mkForce "pl_PL.UTF-8";
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

  # Printing
  services.printing.enable = true;

  # Networking
  networking.networkmanager.enable = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Timezone
  time.timeZone = "Europe/Warsaw";

  # Git configuration
  programs.git = {
    enable = true;
    config = {
      user.name = "Anrzej-serwer";
      user.email = "andrzejfijalo@gmail.com";
      init.defaultBranch = "main";
      core.editor = "nano";
      color.ui = "auto";
      pull.rebase = true;
    };
  };
}

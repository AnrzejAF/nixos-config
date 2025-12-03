{ pkgs, ... }:

{
  # Nix settings: trust the server user for limited operations
  nix.settings.trusted-users = [ "root" "anrzej-serwer" ];

  # Minimal user groups
  users.groups.plugdev = { };

  users.users.anrzej-serwer = {
    isNormalUser = true;
    description = "anrzej-serwer";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ];

    # Minimal set of per-user packages for server usage
    packages = with pkgs; [
      htop
      tmux
      openssh
      vscode
      stremio
    ];
  };

  # Minimal program/service toggles for a headless server
  programs.zsh.enable = true;
  programs.ssh.startAgent = false;

  # Docker is enabled globally in the host config; keep the user in the docker group
  virtualisation.docker.enable = true;

  # Don't enable desktop-specific services on server
  programs.kdeconnect.enable = false;
  programs.steam.enable = false;
  programs.git.enable = false;
}

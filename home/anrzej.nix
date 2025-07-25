{ pkgs, ... }:

{
  home.username = "anrzej";
  home.homeDirectory = "/home/anrzej";
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;

    userName = "Anrzej";
    userEmail = "andrzejfijalo@gmail.com";

    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      lg = "log --oneline --graph --decorate";
    };

    extraConfig = {
      core.editor = "nano";
      color.ui = "auto";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    kdePackages.kate
    wget
    git
    brave
    htop
    telegram-desktop
    vscode 
    flatpak
    zsh
    stow
  ];
}

{ config, pkgs, ... }:

{
  users.users.anrzej = {
    isNormalUser = true;
    description = "anrzej";
    extraGroups = [ "networkmanager" "wheel" "dialout" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
      vscode
      brave
      stow
    ];
  };

  programs.zsh.enable = true;

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

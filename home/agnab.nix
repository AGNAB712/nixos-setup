{ config, pkgs, ... }:

{
  home.username = "agnab";
  home.homeDirectory = "/home/agnab";

  home.stateVersion = "25.05";

  programs.git.enable = true;
  programs.zsh.enable = true;

  home.packages = with pkgs; [
    
  ];

  xdg.configFile."hypr/hyprland.conf".source =
    ../dotfiles/hypr/hyprland.conf;
}

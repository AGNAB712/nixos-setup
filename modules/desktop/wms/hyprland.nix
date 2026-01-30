{ config, pkgs, lib, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    waybar
    rofi
    nwg-look
    matugen
    swww
    adwaita-icon-theme
    gtk-engine-murrine
    quickshell
    playerctl
    eww
    maia-icon-theme
    cava
    quickshell
    imagemagick 
    jq
  ];  

  programs.hyprland.enable = true;
 

}

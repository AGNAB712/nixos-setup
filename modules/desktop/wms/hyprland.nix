{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprland
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
  ];  
}

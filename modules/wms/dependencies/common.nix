{ config, pkgs, lib, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    quickshell
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtquickcontrols
    libnotify
    nwg-look
    swww
    adwaita-icon-theme
    gtk-engine-murrine
    playerctl
    eww
    maia-icon-theme
    cava
    imagemagick 
    jq
    networkmanager_dmenu
    mission-center
    pcmanfm
  ];  
}

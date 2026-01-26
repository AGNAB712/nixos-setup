{ config, pkgs, lib, ... }:

let
  sddmCorners = pkgs.callPackage ./../../packages/sddm-corners/sddm-corners.nix {};
in
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
    sddmCorners
    pkgs.qt6.qt5compat
    eww
    maia-icon-theme
    cava
  ];  

  services.displayManager.sddm = {
    enable = true;
    theme = "corners";
    extraPackages = [ sddmCorners pkgs.qt6.qt5compat ];
    wayland.enable = true;
  };
  services.displayManager.defaultSession = "hyprland";
}

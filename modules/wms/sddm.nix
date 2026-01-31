{ config, pkgs, lib, ... }:

let
  sddmCorners = pkgs.callPackage ./../../../packages/sddm-corners/sddm-corners.nix {};
in
{
  environment.systemPackages = with pkgs; [
    sddmCorners
    pkgs.qt6.qt5compat
  ];  

  services.displayManager.sddm = {
    enable = true;
    theme = "corners";
    extraPackages = [ sddmCorners pkgs.qt6.qt5compat ];
    wayland.enable = true;
  };

  services.displayManager.defaultSession = "hyprland";
}

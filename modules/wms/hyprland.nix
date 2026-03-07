{ config, pkgs, lib, inputs, wrappers, ... }:

{
  imports =
    [
      ./dependencies/common.nix
      ./dependencies/gtk.nix
      ./dependencies/wrapped.nix
    ];
  programs.hyprland.enable = true;
}

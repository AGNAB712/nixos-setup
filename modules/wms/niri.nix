{ config, pkgs, lib, inputs, wrappers, ... }:

# niri configuration
{
  nixpkgs.overlays = [
    (import ../../overlays/niri/niri-resize-overlay.nix)
  ];

  imports = [
    ./dependencies/common.nix
    ./dependencies/gtk.nix
    ./dependencies/wrapped.nix
  ];

  programs.niri.enable = true;
}
{ config, pkgs, lib, inputs, wrappers, ... }:

# mango configuration
{
  imports =
    [
      ./dependencies/common.nix 
      ./dependencies/gtk.nix
      ./dependencies/wrapped.nix
    ];

  programs.mango.enable = true;
}


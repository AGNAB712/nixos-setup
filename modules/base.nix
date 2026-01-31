{ config, pkgs, ... }:

let
  flakePath = "$HOME/nixos";
  flakeTarget = "desktop"; #i will figure out a way to make this better later
in
{
  
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixr" ''
      exec sudo nixos-rebuild switch --flake ${flakePath}#${flakeTarget}
    '')

    (pkgs.writeShellScriptBin "nixy" ''
      exec codium "$HOME/nixos"
    '')
    vscodium
  ];
}

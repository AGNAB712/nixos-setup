{ config, pkgs, ... }:

let
  flakePath = "/etc/nixos";
  flakeTarget = config.networking.hostName;
in
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixr" ''
      exec sudo nixos-rebuild switch --flake ${flakePath}#${flakeTarget}
    '')

    (pkgs.writeShellScriptBin "nixy" ''
      exec codium "$HOME/nixos"
    '')
  ];
}

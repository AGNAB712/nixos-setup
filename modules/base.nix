{ config, pkgs, ... }:

let
  flakePath = "$HOME/nixos";
in
{
  environment.systemPackages = with pkgs; [
    jq
    (pkgs.writeShellScriptBin "nixr" ''
      #!/usr/bin/env bash
      #thanks chatgpt
      set -euo pipefail

      flakePath="$HOME/nixos"
      hostsFile="$flakePath/hosts/hosts.json"

      hostname=$(hostname)
      flakeTarget=$(jq -r --arg host "$hostname" '.[$host] // empty' "$hostsFile")

      exec sudo nixos-rebuild switch --flake "$flakePath#$flakeTarget"
    '')

    (pkgs.writeShellScriptBin "nixy" ''
      exec codium "$HOME/nixos"
    '')

    vscodium
  ];
}

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

    (pkgs.writeShellScriptBin "rwallpaper" ''
      #!/usr/bin/env bash

      WALLPAPER_DIR="$HOME/nixos/dotfiles/wallpapers/pringle"
      RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n 1)
      echo "$RANDOM_WALLPAPER"
      matugen image "$RANDOM_WALLPAPER"
    '')

    vscodium
  ];
}

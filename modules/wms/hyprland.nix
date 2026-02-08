{ config, pkgs, lib, inputs, wrappers, ... }:

let 
  alacritty = wrappers.wrapPackage {
    inherit pkgs;
    package = pkgs.alacritty;
    flags = {
      "--config-file" = "$HOME/nixos/dotfiles/alacritty/alacritty.toml";
    };
  };

  rofi = wrappers.wrapPackage {
    inherit pkgs;
    package = pkgs.rofi;
    flags = {
      "-theme" = "$HOME/nixos/dotfiles/rofi/launchers/custom.rasi";
    };
  };

  dunst = wrappers.wrapPackage {
    inherit pkgs;
    package = pkgs.dunst;
    flags = {
      "-config" = "$HOME/nixos/dotfiles/dunst/dunstrc";
    };
  };

  waybar = wrappers.wrapPackage {
    inherit pkgs;
    package = pkgs.waybar;
    flags = {
      "-c" = "$HOME/nixos/dotfiles/waybar/config.jsonc";
      "-s" = "$HOME/nixos/dotfiles/waybar/style.css";
    };
  };

  fastfetch = wrappers.wrapPackage {
    inherit pkgs;
    package = pkgs.fastfetch;
    flags = {
      "--config" = "$HOME/nixos/dotfiles/fastfetch/config.jsonc";
    };
  };

  #the actual hyprland wrapped package is in the flake because i wanted different configs for different hosts
in 
{
  environment.systemPackages = with pkgs; [
    alacritty
    dunst
    waybar
    rofi
    fastfetch

    libnotify
    nwg-look
    swww
    adwaita-icon-theme
    gtk-engine-murrine
    quickshell
    playerctl
    eww
    maia-icon-theme
    cava
    quickshell
    imagemagick 
    jq
    networkmanager_dmenu
  ];  

  programs.hyprland.enable = true;
 

}

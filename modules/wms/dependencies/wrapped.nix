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
      "-no-levenshtein-sort" = true;
      "-sort" = true;
    };
  };

  matugen = wrappers.wrapPackage { 
    inherit pkgs; 
    package = pkgs.matugen; 
    flags = { 
      "-c" = "$HOME/nixos/dotfiles/matugen/config.toml"; 
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
in 
{
  environment.systemPackages = with pkgs; [
    matugen
    alacritty
    wired
    waybar
    rofi
    fastfetch
  ];  
}

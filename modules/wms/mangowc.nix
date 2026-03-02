{ config, pkgs, lib, inputs, wrappers, ... }:

let 
  alacritty = wrappers.wrapPackage {
    inherit pkgs;
    package = pkgs.alacritty;
    flags = {
      "--config-file" = "$HOME/nixos/dotfiles/alacritty/alacritty.toml";
    };
  };


in 
{
  environment.systemPackages = with pkgs; [
  ];  

  gtk.iconTheme = {
    name = "pringle";
    package = pkgs.stdenv.mkDerivation {
      name = "pringle-icons";
      src = ../../dotfiles/hidden/gtktheme/pringle;

      installPhase = ''
        mkdir -p ~/.local/share/icons/pringle
        cp -r * ~/.local/share/icons/pringle
      '';
    };
  };

    programs.mango.enable = true; 

}

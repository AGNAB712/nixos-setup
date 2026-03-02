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

    programs.mango.enable = true; 

}

{ config, pkgs, lib, ... }:

{
  
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [ 
    roboto 
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts 
    ubuntu-classic
    lato
    cantarell-fonts
  ];
}



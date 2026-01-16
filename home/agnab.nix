{ config, pkgs, ... }:

{
  home.username = "agnab";
  home.homeDirectory = "/home/agnab";
  home.stateVersion = "25.05";

  programs.git.enable = true;
  programs.zsh.enable = true;

  home.packages = with pkgs; [
    
  ];

  home.file."bin/nixy".text = ''
    #!/usr/bin/env bash
    exec codium "$HOME/nixos"
  '';
  home.file."bin/nixy".executable = true;

  home.file."bin/nixr".text = ''
    #!/usr/bin/env bash
    exec codium "sudo nixos-rebuild switch --flake /etc/nixos#desktop"
  '';
  home.file."bin/nixr".executable = true;

}

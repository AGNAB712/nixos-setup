{ pkgs, inputs, ... }:

{
  home.username = "agnab";
  home.homeDirectory = "/home/agnab";
  home.stateVersion = "25.05";

  programs.git.enable = true;
  programs.zsh.enable = true;

  

  services.cliphist = {
    enable = true;
    systemdTargets = ["config.wayland.systemd.target"];
    extraOptions = [
      "-max-dedupe-search"
      "10"
      "-max-items"
      "500"
    ];
    allowImages = true;
  };

  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

 
  
}

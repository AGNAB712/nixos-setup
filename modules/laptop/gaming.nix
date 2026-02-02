{ config, pkgs, lib, ... }:

{
  programs.steam = {
    enable = true;
  };
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    lutris
  ];
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia.modesetting.enable = true;
  nixpkgs.config.allowUnfree = true;
}
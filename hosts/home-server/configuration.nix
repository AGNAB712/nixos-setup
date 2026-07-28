{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/home-server/server.nix
    ../../modules/home-server/agnabot.nix
    ../../modules/home-server/homeserver-dashboard.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.homeserver-dashboard = {
    enable = true;
    port = 3000;
    openFirewall = true;
  };


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.agnab = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "plugdev" "uucp" "audio" "docker" ];
  };

  networking.networkmanager.enable = true;
  networking.hostName = "homeserver";
  time.timeZone = "America/Chicago";

  system.stateVersion = "25.11";
}

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/home-server/server.nix
  ];

  users.users.agnab = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "plugdev" "uucp" "audio" "docker" ];
  };

  networking.hostName = "homeserver";
  time.timeZone = "America/Chicago";

  system.stateVersion = "24.05";
}

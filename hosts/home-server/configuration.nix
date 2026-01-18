{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/home-server/server.nix
  ];

  networking.hostName = "homeserver";
  time.timeZone = "America/Chicago";

  system.stateVersion = "24.05";
}

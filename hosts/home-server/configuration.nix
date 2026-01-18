{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/server.nix
  ];

  networking.hostName = "server";

  services.openssh.enable = true;

  time.timeZone = "America/Chicago";

  system.stateVersion = "24.05";
}

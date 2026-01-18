{ config, pkgs, ... }:

{
  services.openssh.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  users.users.agnab.extraGroups = [ "docker" ];
}

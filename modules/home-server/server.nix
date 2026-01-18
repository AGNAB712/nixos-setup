{ config, pkgs, ... }:

{
  services.openssh.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-uuid/3962ed81-cdf0-498f-aa3e-30aba2a3e3f1";
    fsType = "ext4";
  };
  fileSystems."/media" = {
    device = "/dev/disk/by-uuid/3e00a70c-3846-4298-9ec3-24d5cdf4e7b7";
    fsType = "ext4";
  };

  users.users.agnab.extraGroups = [ "docker" ];
}

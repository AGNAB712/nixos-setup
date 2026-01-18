{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    passwordAuthentication = true;
  };

  networking.firewall.allowedTCPPorts = [
    22
    80
    443
  ];

  services.jellyfin.enable = true;
  services.samba.enable = true;

  virtualisation.docker.enable = true;
}

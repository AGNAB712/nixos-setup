{ pkgs, ... }:

# tailscale VPN configuration and related packages
{
  environment.etc."tailscale/config.json".text = builtins.toJSON {
    version = "alpha0";
    operatorUser = "agnab";
  };

  services.tailscale = {
    enable = true;
  };

  networking.extraHosts = ''
    100.76.183.58 homeserver.local 
  '';
}
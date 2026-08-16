{ pkgs, ... }:

# mullvad VPN configuration and related packages
{
  environment.systemPackages = with pkgs; [
    mullvad #client
    mullvad-vpn  #service
  ];

  services.resolved.enable = true; 

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}


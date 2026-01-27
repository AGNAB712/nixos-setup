{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mullvad
    mullvad-vpn
  ];

  services.resolved.enable = true; 
  #lets mullvad work, before i got it to connect but the nameservers seemed fucked up

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
  #have to specify the package because it isn't updated yet, might be breaking?
}

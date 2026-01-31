{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;

    #trust me.... one day i will figure out how to rice this
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
        luadbi-mysql
      ];
    };
  };
}

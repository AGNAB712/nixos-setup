{ config, pkgs, ... }:

{
  systemd.services.agnabot = {
    description = "agnabot (very descriptive)";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
        ExecStart = "${agnabot.packages.${system}.default}/bin/agnabot";
        Restart = "always";
        User = "agnab";
    };
  };
}




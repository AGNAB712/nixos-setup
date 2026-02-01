{ config, pkgs, agnabot, ... }:

{
  systemd.services.agnabot = {
    description = "agnabot (very descriptive)";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${agnabot.packages.${config.system.arch}.default}/bin/agnabot";
      Restart = "always";
      User = "agnab";
    };
  };
}




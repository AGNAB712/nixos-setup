{ config, pkgs, ... }:

let
  agnabotDir = "/home/agnab/agnabot";
  agnabotDataDir = "/var/lib/agnabot";
in
{
  systemd.tmpfiles.rules = [
    "d ${agnabotDataDir} 0755 agnab users -"
  ];

  systemd.services.agnabot = {
    description = "Agnabot Discord bot (nix run)";
    after = [ "network.target" ];

    serviceConfig = {
      Type = "simple";
      WorkingDirectory = agnabotDir;
      Environment = "AGNABOT_DATA_DIR=${agnabotDataDir}";
      ExecStart = "${pkgs.nix}/bin/nix run ${agnabotDir}#default";
      Restart = "always";
      RestartSec = 5;
    };
  };

  systemd.services.agnabot-update = {
    description = "update agnabot from git";
    serviceConfig = {
      Type = "oneshot";
      WorkingDirectory = agnabotDir;
      ExecStart = ''
        git fetch --all
        git reset --hard origin/main
        systemctl --user restart agnabot.service
      '';
      User = "agnab";
    };
  };

  systemd.timers.agnabot-update = {
    description = "run agnabot git update every 5 minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "5min";
    };
  };
}

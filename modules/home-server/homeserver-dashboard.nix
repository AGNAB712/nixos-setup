{ config, lib, pkgs, ... }:

let
  cfg = config.services.homeserver-dashboard;
in
{
  options.services.homeserver-dashboard = {
    enable = lib.mkEnableOption "Homeserver dashboard";

    packageDir = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/storage/dashboard";
      description = "Path to the dashboard source directory.";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 3000;
      description = "Port for the dashboard HTTP server.";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "dashboard";
      description = "User that runs the dashboard service.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "dashboard";
      description = "Primary group for the dashboard service user.";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to open the dashboard port in the firewall.";
    };
  };

  config = lib.mkIf cfg.enable {
    users.groups.${cfg.group} = {};

    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      extraGroups = [ "docker" ];
    };

    systemd.services.homeserver-dashboard = {
      description = "Homeserver Dashboard";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" "docker.service" ];
      wants = [ "network-online.target" ];

      path = [ pkgs.nodejs_20 ];

      environment = {
        NODE_ENV = "production";
        PORT = toString cfg.port;
        DOCKER_SOCKET = "/var/run/docker.sock";
      };

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        WorkingDirectory = cfg.packageDir;
        ExecStart = "${pkgs.nodejs_20}/bin/npm start";
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };

    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ cfg.port ];
  };
}

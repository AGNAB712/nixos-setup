{ config, pkgs, lib, ... }:

let
  flakePath = "/etc/nixos";
  flakeTarget = config.my.flakeTarget or "desktop"; # fallback if not set
in
{
  home.username = "agnab";
  home.homeDirectory = "/home/agnab";
  home.stateVersion = "25.05";


  programs.git.enable = true;
  programs.zsh.enable = true;

  home.packages = with pkgs; [
  ];

  services.cliphist = {
    enable = true;
    systemdTargets = ["config.wayland.systemd.target"];
    extraOptions = [
      "-max-dedupe-search"
      "10"
      "-max-items"
      "500"
    ];
    allowImages = true;
  };

  systemd.user.services.eww-weather = {
  Unit = {
    Description = "eww weather updater";
  };

  Service = {
    Type = "oneshot";
    ExecStart = "%h/.config/eww/scripts/weather.sh --getdata";
  };
};

  systemd.user.timers.eww-weather = {
    Unit = {
      Description = "run eww weather updater periodically";
    };

    Timer = {
      OnBootSec = "5m";
      OnUnitActiveSec = "1hr";
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

}

{ pkgs, inputs, ... }:

{
  home.username = "agnab";
  home.homeDirectory = "/home/agnab";
  home.stateVersion = "25.05";

  programs.git.enable = true;
  programs.zsh.enable = true;

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

  imports = [
    inputs.nixcord.homeModules.nixcord
  ];
  programs.nixcord = {
    enable = true;

    vesktop.enable = true;

    # Theming
    quickCss = "/* css goes here */";
    config = {
      useQuickCss = false;
      enabledThemes = ["midnight (vencord)"];

      #plugins = {

      #};
    };
  };

  systemd.user.services.lb-discord-rpc = {
    description = "ListenBrainz Discord RPC";
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = "/home/agnab/lb-discord-rpc/target/release/lb-discord-rpc";
      Environment = [
        "LB_USER=agnab"
        "DISCORD_CLIENT_ID=1466936443141361814"
      ];
      Restart = "always";
    };

    wantedBy = [ "default.target" ];
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

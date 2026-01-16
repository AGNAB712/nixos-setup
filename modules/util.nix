{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
    polkit_gnome
    unzip
    fastfetch
    nitch
    bibata-cursors
    grim
    flameshot
    libnotify
    dunst
    usbutils
    psmisc
  ];

  services.tailscale = {
    enable = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.variables = {
    PATH = ["$HOME/bin"];
  };


  systemd.services."esp-keyboard-detector" = {
    description = "esp keyboard detector";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.nodejs}/bin/node /home/agnab/esp-keyboard-detector/index.js";
      Restart = "always";
      Type = "simple";
      User = "agnab";
      Environment = "NODE_ENV=production";
    };
  };

}



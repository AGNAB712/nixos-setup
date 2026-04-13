{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
    polkit_gnome
    unzip
    nitch
    bibata-cursors
    grim
    flameshot
    usbutils
    psmisc
    flatpak
    pkgs.cliphist
    gparted
    jq
    brightnessctl
    powertop
    cmatrix
    pipes
    clock-rs
    mission-center
    system-config-printer
    obs-studio
    (discord.override {
      # withOpenASAR = true; # can do this here too
      withVencord = true;
    })
    rar
    openspeedrun
    keyd
    parsec-bin
    py7zr
    noisetorch
  ];

  programs.noisetorch.enable = true;

  security.polkit.enable = true;
    services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  xdg.portal.wlr.enable = true;

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


  services.udev.extraRules = ''
    KERNEL=="ttyUSB*", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", GROUP="users", MODE="0660"
  '';
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

  services.keyd = {
    enable = true;
  };

  hardware.graphics.enable = true;

  powerManagement.cpuFreqGovernor = "performance"; 
  powerManagement.cpufreq.max = 4500000;
  powerManagement.cpufreq.min = 800000;
  #because my outlets suck

}



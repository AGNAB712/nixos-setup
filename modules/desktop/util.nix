# General utilities and system services configuration
{ config, pkgs, inputs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
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
    vesktop
    rar
    openspeedrun
    keyd
    parsec-bin
    py7zr
    noisetorch
    slurp
    fuzzel
    qbittorrent
    wl-clicker
    pulseaudioFull
    conky
    appimage-run
  ];

  # Enable noisetorch globally
  programs.noisetorch.enable = true;

  # Enable polkit for authentication dialogs
  security.polkit.enable = true;

  # Enable printing services
  services.printing.enable = true;

  # Enable Avahi for local network service discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable Tailscale VPN service
  services.tailscale = {
    enable = true;
  };

  environment.pathsToLink = [
    "/share/wireplumber"
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };

  security.rtkit.enable = true;

  hardware.pulseaudio.enable = false;

  # Add user's local bin to PATH
  environment.variables = {
    PATH = ["$HOME/bin"];
  };

  # Extra udev rules for specific USB devices
  services.udev.extraRules = ''
    KERNEL=="ttyUSB*", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", GROUP="users", MODE="0660"
  '';

  # Custom systemd service for ESP keyboard detector
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

  # Enable keyd key remapping
  services.keyd = {
    enable = true;
  };

  # Enable graphics hardware support
  hardware.graphics.enable = true;

  # CPU frequency governor and limits
  powerManagement.cpuFreqGovernor = "performance"; 
  powerManagement.cpufreq.max = 4500000;
  powerManagement.cpufreq.min = 800000;
  #comment: because my power outlets are suboptimal
}

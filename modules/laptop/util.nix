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
    flatpak
    pkgs.cliphist
    gparted
    jq
    brightnessctl
    powertop
  ];

  security.polkit.enable = true;

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

  hardware.graphics.enable = true;


}



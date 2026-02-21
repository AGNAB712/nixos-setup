{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
    polkit_gnome
    unzip
    rar
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
    rembg
    pkgs.xdg-desktop-portal-hyprland
    system-config-printer
    colloid-gtk-theme
    cameractrls
  ];

  /*gtk.theme.package = pkgs.colloid-gtk-theme;
  gtk.theme.name = "Colloid-Dark";*/

  services.gnome.gnome-keyring.enable=true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  security.polkit.enable=true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };


  services.blueman.enable = true;
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

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

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

}



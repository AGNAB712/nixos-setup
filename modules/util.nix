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
  ];

  security.polkit.enable = true;

  services.flatpak.enable = true;
  system.activationScripts.flathub-add = ''
    if ! flatpak remotes | grep -q "flathub"; then
      flatpak remote-add --if-not-exists flathub "https://flathub.org/repo/flathub.flatpakrepo"
    fi
  '';
  system.activationScripts.bambu-install = ''
    if ! flatpak list | grep -q "com.bambulab.BambuStudio"; then
      flatpak install -y flathub com.bambulab.BambuStudio
    fi
  '';
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

}



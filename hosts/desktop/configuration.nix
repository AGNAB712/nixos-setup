# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      #applications
      ../../modules/desktop/productivity.nix
      ../../modules/desktop/util.nix
      ../../modules/desktop/gaming.nix
      ../../modules/desktop/openclaw.nix

      #mounts
      ../../modules/mounts/server.nix
      ../../modules/mounts/windows.nix

      #window managers (probably DEs later too)
      ../../modules/wms/hyprland.nix
      ../../modules/wms/sddm.nix
      ../../modules/wms/mangowc.nix

      #global
      ../../modules/base.nix
      ../../modules/fonts.nix
      ../../modules/mullvad.nix
    ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "agnab" ];

  services.caddy.virtualHosts."openclaw.nixos.local" = {
    extraConfig = ''
      reverse_proxy localhost:8080
      tls internal
    '';
  };

  services.gnome.gnome-keyring.enable=true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  security.polkit.enable=true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "agnabspc";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
  };

  users.users.agnab = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "plugdev" "uucp" "audio" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  ];

  services.openssh.enable = true;
  system.stateVersion = "25.11";

}

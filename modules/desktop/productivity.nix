# Productivity focused packages and configurations
{ config, pkgs, inputs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    librewolf
    pywalfox-native
    pywal
    vscodium
    git
    gh
    github-desktop
    arduino-ide
    python3
    nodejs
    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio-extras
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    openssh
    blender
    android-studio
    bottles
    kdePackages.kdenlive
    feishin
    image-roll
    glib
    gsettings-desktop-schemas
    vlc
    zathura
    pkgs.kdePackages.dolphin-plugins
    pkgs.kdePackages.baloo-widgets
    pkgs.kdePackages.baloo
    pkgs.kdePackages.kservice
    pkgs.kdePackages.ark
    pkgs.xdg-utils
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-gtk
    python313Packages.uvicorn
    comic-mandown
    cloudflared
    docker
    openclaw
    codex
    wine
    libreoffice-qt
  ];

  virtualisation.docker.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "openclaw-2026.5.7"
  ];

  # Set the KDE Plasma applications menu
  environment.etc."xdg/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # Flatpak packages to install
  services.flatpak.packages = [
    "com.bambulab.BambuStudio"
    "com.discordapp.Discord"
  ];

  # Environment variable tweaks for librewolf
  environment.etc."profile.d/librewolf/sh".text = ''
    export MOZ_ENABLE_WAYLAND=1
    export LIBGL_DRI3_DISABLE=1
  '';
}
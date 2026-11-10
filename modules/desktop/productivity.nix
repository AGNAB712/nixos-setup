# Productivity focused packages and configurations
{ config, pkgs, inputs, lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      tauon = prev.tauon.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          substituteInPlace src/tauon/t_modules/t_main.py \
            --replace-fail 'from pypresence import ActivityType, StatusDisplayType, Presence' 'from lynxpresence import ActivityType, StatusDisplayType, Presence' \
            --replace-fail 'is_module_loaded("pypresence", "ActivityType")' 'is_module_loaded("lynxpresence", "ActivityType")' \
            --replace-fail 'Missing dependency python-pypresence' 'Missing dependency lynxpresence'
        '';
      });
    })
  ];

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
    tauon
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
    wineWow64Packages.staging
    winetricks
    virt-manager
    qemu_kvm
    swtpm
    cmake
    teams-for-linux
    nix-index
  ];

  programs.droidcam.enable = true;
  services.usbmuxd.enable = true;

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      droidcam-obs
    ];
  };

  virtualisation.docker.enable = false;

  nixpkgs.config.permittedInsecurePackages = [
    "openclaw-2026.5.7"
    "pnpm-9.15.9"
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

{ config, pkgs, lib, ... }:

{
  programs.steam = {
    enable = true;
  };
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common.default = lib.mkForce [ "wlr" "gtk" ];
      mango.default = lib.mkForce [ "wlr" "gtk" ];
    };
  };


  environment.systemPackages = with pkgs; [
    mangohud
    lutris
    flitter
    flatpak
    ryubing
    prismlauncher
    gale
    android-tools
    slimevr
  ];
  services.wivrn.enable = true;
  services.flatpak.enable = true;
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
  services.flatpak.packages = [
    "org.vinegarhq.Sober"
    "com.modrinth.ModrinthApp"
  ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia.modesetting.enable = true;
  nixpkgs.config.allowUnfree = true;
  hardware.nvidia.prime = {
    sync = {
      enable = true;
    };

    # integrated
    amdgpuBusId = "PCI:10:0:0";
    
    # dedicated
    nvidiaBusId = "PCI:1:0:0";
  };
  
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    libice
    libsm
    libx11
    libxext
    libxrandr
    openal
    SDL2
    icu
    fontconfig
    sndio
    alsa-lib
    libpulseaudio
    libGL
    vulkan-loader
    wayland
    dbus
    freetype
    zlib
    stdenv.cc.cc
    ];
  };
  
}

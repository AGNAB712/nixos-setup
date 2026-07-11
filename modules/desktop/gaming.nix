# Gaming related programs and configurations
{ config, pkgs, inputs, lib, ... }:
{
  programs.steam = {
    enable = true;  # Enable Steam client
  };
  programs.steam.gamescopeSession.enable = true;  # Enable gamescope sessions for Steam
  programs.gamemode.enable = true;  # Enable GameMode for performance optimization

  # Enable xdg portals for wayland/gtk support
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
    blockbench
  ];

  # Enable services relevant to gaming
  services.wivrn.enable = true;
  services.flatpak.enable = true;
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [ 9757 ];
    allowedUDPPorts = [ 9757 ];
  };

  services.flatpak.packages = [
    "org.vinegarhq.Sober"
    "com.modrinth.ModrinthApp"
  ];

  # Graphics hardware configuration
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

    # Bus IDs for integrated and dedicated GPUs
    amdgpuBusId = "PCI:10:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  
  # nix-ld library dependencies
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

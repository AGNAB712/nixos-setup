{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    librewolf
    pywalfox-native
    pywal
    vscodium
    git
    github-desktop
    discord
    arduino-ide
    python3
    nodejs
    rembg
    kdePackages.dolphin
    kdePackages.qtsvg
    samba
    kdePackages.kio-extras
    openssh
    blender
    android-studio
    jellyfin-desktop
    mullvad-vpn
  ];

  fileSystems."/mnt/homeserver" = {
    device = "//10.0.0.86/Data";
    fsType = "cifs";
    options = [ 
      "credentials=/home/agnab/.smbcredentials" 
      "vers=3.0" 
      "rw" 
      "uid=1000" 
      "gid=100" 
      "_netdev"
      "nofail"
      "x-systemd.automount"
      "x-systemd.device-timeout=3"
    ];
  };

  fileSystems."/mnt/storage" = {
    device = "//10.0.0.86/mnt";
    fsType = "cifs";
    options = [ 
      "credentials=/home/agnab/.smbcredentials" 
      "vers=3.0" 
      "rw" 
      "uid=1000" 
      "gid=100" 
      "_netdev"
      "nofail"
      "x-systemd.automount"
      "x-systemd.device-timeout=3"
    ];
  };

  environment.etc."profile.d/librewolf/sh".text = ''
    export MOZ_ENABLE_WAYLAND=1
    export LIBGL_DRI3_DISABLE=1
  '';
}

{ pkgs, ... }:

# mounts but tailscale
{
  environment.systemPackages = with pkgs; [
    samba
  ];

  networking.extraHosts = ''
    100.76.183.58 homeserver.local 
  '';

  # main homeserver Data share
  fileSystems."/mnt/homeserver" = {
    device = "//homeserver.local/Data";
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

  # main homeserver storage share
  fileSystems."/mnt/storage" = {
    device = "//homeserver.local/mnt";
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
}


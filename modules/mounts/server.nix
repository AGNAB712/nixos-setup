{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    samba
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

}

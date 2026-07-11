{ pkgs, ... }:

# mount windows
{
  fileSystems."/mnt/windows" = {
    device = "/dev/nvme0n1p4";
    fsType = "ntfs";
    options = [ 
      "nofail"
      "users"
    ];
  };

}


{ pkgs, ... }:

{
  fileSystems."/mnt/windows" = {
    device = "/dev/nvme0n1p4";
    fsType = "ntfs";
    options = [ 
      "nofail"
      "users"
    ];
  };
  # sudo mount -t ntfs /dev/nvme0n1p4 /mnt/windows
}

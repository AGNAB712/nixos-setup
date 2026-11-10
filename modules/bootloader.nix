{ ... }:

{
  boot = {
    loader.grub = {
      enable = true;
      theme = ../dotfiles/grub;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      copyKernels = false;
      splashImage = null;
    };

    loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };

    # Keep the handoff from GRUB to Plymouth quiet.
    consoleLogLevel = 0;
    initrd.verbose = false;

    kernelParams = [
      "quiet"
      "splash"
      "systemd.show_status=false"
      "rd.systemd.show_status=false"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
      "nvidia_drm.modeset=1"
    ];

    loader.timeout = 5;

    plymouth = {
      enable = true;
      theme = "nixos-plymouth";
    };

    initrd.systemd.enable = false;
  };

  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];
}

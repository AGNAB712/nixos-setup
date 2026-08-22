{ config, pkgs, ... }:

{
    boot = {
        loader.grub = {
            enable = true;
            device = "nodev";
            efiSupport = true;
            useOSProber = true;
            splashImage = null;
        };
        loader.efi.canTouchEfiVariables = true;

        # Don't show systemd/udev messages.
        consoleLogLevel = 3;
        initrd.verbose = false;

        

        kernelParams = [
        "quiet"
        "splash"
        "rd.systemd.show_status=auto"
        "rd.udev.log_level=3"
        ];

        loader.timeout = 5;

        # Important for getting Plymouth running early.
        initrd.systemd.enable = true;
  };

  hardware.amdgpu.initrd.enable = true;
}


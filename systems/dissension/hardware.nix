{ inputs, ... }:
{
  imports = with inputs.hardware.nixosModules; [
    common-pc-ssd
    common-cpu-amd
    common-gpu-nvidia-nonprime
  ];

  sysc = {
    disko.luks-btrfs.device = "/dev/nvme0n1";
    monitors = [
      {
        # Left monitor
        name = "DP-3";
        width = 1920;
        height = 1080;
        x = 0;
        refreshRate = 165;
        workspace = "1";
      }
      {
        # Center monitor
        name = "HDMI-A-1";
        width = 3440;
        height = 1440;
        x = 1920;
        refreshRate = 100;
        workspace = "2";
      }
      {
        # Right monitor
        name = "DP-1";
        width = 1920;
        height = 1080;
        x = 5360;
        refreshRate = 75;
        workspace = "3";
      }
      {
        # Valve index
        name = "DP-2";
        enabled = false;
      }
    ];
    nvidia = {
      enable = true;
      enableOpen = true;
    };
  };
  hardware = {
    steam-hardware.enable = true;
    keyboard.qmk.enable = true;
  };

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
}

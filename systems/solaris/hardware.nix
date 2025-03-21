{ inputs, ... }:
{
  imports = with inputs.hardware.nixosModules; [
    common-pc-laptop-ssd
    common-cpu-intel-cpu-only
    common-gpu-nvidia-nonprime
  ];

  sysc = {
    disko.luks-btrfs.device = "/dev/nvme0n1";
    monitors = [
      {
        name = "eDP-1";
        width = 1920;
        height = 1080;
        refreshRate = 60;
        workspace = "1";
      }
    ];
    nvidia.enable = true;
  };

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-intel" ];

  hardware.enableRedistributableFirmware = true;
}

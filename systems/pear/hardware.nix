{ inputs, ... }:
{
  imports = with inputs.nixos-hardware.nixosModules; [
    common-pc-ssd
    common-cpu-amd
    common-gpu-nvidia-nonprime
  ];

  hardware = {
    enableRedistributableFirmware = true;
    nvidia.open = false;
  };

  time.hardwareClockInLocalTime = true;

  boot = {
    loader.systemd-boot.windows = {
      "win-11" = {
        title = "Windows";
        efiDeviceHandle = "HD0b";
      };
    };
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    kernelModules = [ "kvm-amd" ];
  };
}

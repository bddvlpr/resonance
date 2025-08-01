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

  boot = {
    loader.systemd-boot.windows = {
      "11-home" = {
        title = "Windows 11 Home";
        efiDeviceHandle = "HD3b";
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

{inputs, ...}: {
  imports = with inputs.hardware.nixosModules; [
    common-pc-laptop-ssd
    common-cpu-intel
    common-gpu-nvidia-nonprime
  ];

  sysc.disko.luks-btrfs.device = "/dev/nvme0n1";

  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
  boot.kernelModules = ["kvm-intel"];

  hardware.enableRedistributableFirmware = true;
}

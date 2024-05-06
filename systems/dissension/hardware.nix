{inputs, ...}: {
  imports = with inputs.hardware.nixosModules; [
    common-pc-ssd
    common-cpu-amd
    # TODO: Enable this once unfree is enabled.
    # common-gpu-nvidia-nonprime
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-amd"];
}

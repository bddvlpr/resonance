{inputs, ...}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    common-pc-laptop-ssd
    common-cpu-intel-cpu-only
    common-gpu-nvidia-nonprime
  ];

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
    kernelModules = ["kvm-intel"];
  };
}

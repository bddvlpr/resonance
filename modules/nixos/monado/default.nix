{pkgs, ...}: {
  services.monado = {
    enable = true;
    defaultRuntime = true;
  };

  systemd.user.services.monado.environment = {
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
  };

  hardware.graphics.extraPackages = with pkgs; [monado-vulkan-layers];
}

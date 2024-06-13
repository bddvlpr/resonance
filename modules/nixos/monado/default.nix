{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.lemonake.packages.${pkgs.system}) monado-vulkan-layers;
in {
  services.monado = {
    enable = true;
    defaultRuntime = true;
  };

  systemd.user.services.monado.environment = {
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
  };

  hardware.opengl.extraPackages = [monado-vulkan-layers];
}
